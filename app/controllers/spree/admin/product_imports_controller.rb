class Spree::Admin::ProductImportsController < Spree::Admin::BaseController
  
  before_action :ensure_valid_file,  only: [:preparse]
  before_action :get_property_name, :get_category_name, :set_loader_options,  only: [:preparse, :import]


  def index    
    @csv_table = CSV.open(Rails.root.join('lib', 'sample_csv_files', 'SpreeMultiVariant.csv'), 
      headers: true).read  if File.exists? Rails.root.join('lib', 'sample_csv_files', 'SpreeMultiVariant.csv')
  end

  def reset
    flash[:success] = Spree::DataResetService.new.reset_products
    redirect_to admin_product_imports_path
  end
 
  def preparse
    begin           
      ext = get_file_type params[:csv_file].path 
      @data_import = []                
      @columns_define = [] 
      header = [] 
      rows = []

      if ext == ".csv"  
        require 'csv'      
        file = CSV.open(params[:csv_file].path , { :col_sep => ","} )                 
           
        file.readlines[0..50].each_with_index do |row, num|     
          rows[num] = row
        end
      end 
      
      if ext == ".xls"      
        ap '******import xls *******'
        require 'roo'
        require 'charlock_holmes/string'

        book = Roo::Spreadsheet.open(params[:csv_file].path, extension: :xls)      
        
        ap '********'
        max_row = 0

        book.sheets.each do |sheet|
          book.default_sheet = sheet
          0.upto(book.last_row) do |index|
            z = book.row(index)
            ap z
            
            ap '******encode'

            ap z.map{|str| str.encode(Encoding.find('UTF-8'), {invalid: :replace, undef: :replace, replace: ''}) if str.present? } 
          end        
        end

        # require 'spreadsheet'
        # source_encoding = "UTF-8" 
        # ap '******encoding******'
        # ap params[:csv_file].external_encoding

       
        # book = Spreadsheet.open $file
        

        # max_row = 0
        # book.worksheets.each do |sheet|
        #   sheet.each_with_index do |row, num|
        #     max_row +=1
        #     break if max_row > 50 
        #     rows[num] = row
        #   end
        # end  
      end

      ap '****** rows ******'
      ap rows


      if rows.present?
        rows.each_with_index do |row, num|
          row.each_with_index do |ceil, ind|            
            if @columns_define[ind].blank? && ceil.present?
              ap ceil
              z = define_string_to_field ceil             
              if z.present?
                @columns_define[ind] = z             
                header << num
              end 
            end
          end            
          @data_import << row                              
        end  
      end  
          
          


      # if ext == ".xlsx"
      # end     
     @uniq_file = random_string + ext
     # FileUtils.cp(params[:csv_file].path, Rails.root.join('tmp/import', @uniq_file))
    rescue => e
      flash[:error] = e.message
    end        
  end

  def import 
    begin
      import_param = params.require(:product_imports).permit(:csv_file, :columns_define=> {})        
      file_name = import_param[:csv_file]
      file_name = '9covCnQdzxnXxFsr7BitrQ.csv'
      ext = get_file_type file_name
      if ext == ".csv"  
        require 'csv'     
        file = CSV.open(Rails.root.join('tmp/import', file_name),  { :col_sep => ","} ) 
        @tovars = []         
        columns = import_param[:columns_define]        
        header = []
        if columns.present? 
          file.readlines[0..100].each do |row|                   
            tovar = {}            
            if is_not_empty_row(row)
              row.each_with_index do |ceil, index|                                                       
                if ceil!= '' && ceil!=nil                
                  header = [index, ceil] if header.blank? && define_string_to_field(ceil).present?                                
                  v = columns[(index+1).to_s]             
                  if v!='' && v!=nil
                    if v == 'name_with_category'
                      tovar['product::name'] = ceil
                      tovar['taxonomy::1'] = search_category_in_name ceil
                    elsif v.include? 'price'
                      tovar[v] = get_number ceil   
                    elsif v == 'taxonomy::1'                       
                       tovar['taxonomy::1'] = search_category ceil                         
                    else 
                      tovar[v] = ceil   
                    end                
                  end
                end  
              end
              tovar[:row] = row
              tovar['product::sku'] = tovar['product::name'] if tovar['product::sku'].blank? && tovar['product::name'].present?
              @tovars << tovar
            end 
          end  
        end                
      end   

      if @tovars.present?
        header = is_header header       
        @tovars.each do |tovar|  
          @tovar = tovar        
          next if header.present? && header[0]==1.present? && @tovar[:row][header[0]] == header[1]  
          next if @tovar['product::sku'].blank?   
          next if @tovar['product::price'].blank?
          next if @tovar['product::price'].to_i < 0
          @tovar['product::cost_price'] = @tovar['product::cost_price'].present? ? @tovar['product::cost_price'] : @tovar['product::price']   
          add_product 
        end  
      end 

      flash[:success] = Spree.t(:successfull_import)

    rescue => e
      ap '******error****'
      ap e
      flash[:error] = e.message
    end    
    # redirect_to admin_product_imports_path
  end


  private  
    #  вспомогательные функции
    def is_header header
      return if header.blank?
      header.each do |h|
        if row_name.include? h 
          return header
        end  
      end
      return
    end

    def get_number s
      return s.gsub(/[^0-9]/, "").to_i
    end

    def get_file_type f 
      return (/\.\w{3,4}$/.match f).to_s.downcase
    end 

    def random_string
      @string ||= "#{SecureRandom.urlsafe_base64}"
    end

    def is_not_empty_row row      
      return row.select{|t| t.present?}.present?
    end

    def get_import_category 
      return 96
    end


    #  прдзагрузка 
    def manipulate_row row
    end


    def ensure_valid_file          
      unless params[:csv_file].try(:respond_to?, :path)
        flash[:error] = Spree.t(:file_invalid_error, scope: :datashift_import)
        redirect_to admin_product_imports_path
      end
    end

    #  текущие свойства
    def get_property_name
      @properties = Spree::Property.accessible_by(current_ability, :read).where.not(:name => 'ID_IMPORT')
      return @properties
    end

    # текущие категории
    def get_category_name   
      @categories = []     
      Spree::Taxonomy.accessible_by(current_ability, :read).find_by_name('Категория товара').taxons.each do |t|         
        @categories << {:id => t.id, :name => t.name.downcase}
        if t.meta_keywords.present?  
          t.meta_keywords.downcase.split(',').each do |k|
            @categories << {:id => t.id, :name => k.downcase.strip} 
          end  
        end  
      end
      return @categories
    end

    # опции которые выбираем пользователь
    def set_loader_options      
      @options = []
      @options << ['Название товара','product::name'] 
      @options << ['Название и категория товара', 'name_with_category']
      @options << ['Розничная цена', 'product::price']      
      @options << ['Количество','product::quantity']
      @options << ['Изображение','product::image']
      @options << ['Артикль','product::sku']      
      @options << ['Описание','product::description']      

      Spree::Taxonomy.accessible_by(current_ability, :read).each do |t|
        @options<< [t.name, 'taxonomy::'+t.id.to_s]
      end

      @properties.each do |t|
        @options << [t.presentation, 'property::'+t.id.to_s]
      end

      return 

      @options << ['---- Цена зависящая от свойств ----', '']  

      Spree::OptionType.accessible_by(current_ability, :read).each do |t|
        t.option_values.each do |v|
          @options<< [t.presentation+' : '+v.presentation, 'variant::'+t.id.to_s]
        end  
      end

    end

    
    # функции 
    # возможные варианты столбца название
    def row_name 
      return ['название товара','название','наименование','имя', 'name', 'title']
    end  


    # определение столбца по названию
    def define_string_to_field define

      define = define.downcase.strip 

      set = {
        'product::name' => row_name,
        'product::price' => ['цена','price','cost'],
        'product::quantity' => ['кол-во','количество', 'кол.'],
        'product::image' => ['фото', 'изображение','image'],
        'taxonomy::2' => ['бренд'],
        'taxonomy::1'   => ['категория'],
        'product::sku' => ['артикль','арт.'],
      }

      set.each do |d, t|                             
        return d if t.select{|l| define == l.downcase}.present?           
      end
      return @options.select{|l, t| t if define == l.downcase}
      return false 
    end 

    # выбираем категорию по названию
    def search_category_in_name str 
      result = nil   
      count = 0    
      @categories.each do |t| 
        if str.downcase.include? t[:name]
          if t[:name].mb_chars.length > count   
            count = t[:name].mb_chars.length 
            result = t[:id]
          end  
        end      
      end    
      return result
    end 
  
    # поиск просто по категории 
    def search_category str       
      str = str.strip.downcase
      @categories.each do |t|         
        if str == t[:name]
          return t[:id]
        end      
      end          
      #  создаем новую подкатегорию в категорию импорт       
      n = Spree::Taxon.create!(:name => str.capitalize , :taxonomy_id => 1, :parent_id => get_import_category ) 
      if n.present?         
        @categories << {:id => n.id, :name => str}
        return n.id   
      end
    end 
    

    def add_product  
      ap '****** add_product******'
      return if @tovar['product::sku'].blank?
      sku = get_sku_tovar 
      pro = Spree::Variant.find_by_sku(sku)           
      if pro  
        @product=pro.product            
        update_tovar 
      else
        create_tovar sku     
      end     
    end


    # создаем уникальный номер товара по полю ску и продавцу 
    def get_sku_tovar 
      require 'digest'      
      return Digest::MD5.hexdigest @tovar['product::sku'] + spree_current_user[:id].to_s
    end

    def update_tovar
      ap '*****update_tovar*****'
      return if !@tovar['product::name'].present?
      return if !@tovar['product::price'].present?   
      update_all     
      @product.save
    end

    def create_tovar sku
      ap '****create_tovar******'
      return if !@tovar['product::name'].present?
      return if !@tovar['product::price'].present?       

      @product = Spree::Product.create(:name =>@tovar['product::name'], :price =>  @tovar['product::price'] , 
        :sku => sku, 
        :cost_price => @tovar['product::cost_price'],
        :shipping_category_id => 1,
      )

      update_all

      @product.save
    end


    def update_all
      return if @product.blank?
      return if @tovar.blank?
      @tovar.each do |v, t|        
        next if !v.kind_of?(String)
        if v.include?('taxonomy')         
          update_taxonomy v            
        end  
        if v.include?('property')
          update_property v
        end  
        if v.include?('variant')
          update_variant v
        end
        if v=='product::image'
          update_image
        end
      end
      @product.available_on = Time.now - 90000 unless @product.available_on     
    end  

    def update_taxonomy name_taxon     
      return if @product.blank?
      return if @tovar.blank?
      if @tovar[name_taxon].present?
        taxon_id = get_number name_taxon  
        str = taxon_id == 1 ? @tovar[name_taxon] : @tovar[name_taxon].strip
        taxonomy = Spree::Taxonomy.find_by_id(taxon_id).taxons        
        if taxon_id == 1 
          taxon = taxonomy.find_by_id(str)          
        else 
          taxon = taxonomy.find_or_create_by(:name => str, :parent_id => taxonomy.where(:parent => nil).pluck(:id).first)    
        end
        # выбираем все таксоны которые есть по таксономии 
        product_taxons = @product.taxons.select{|t| t.taxonomy_id == taxon_id} 

        if product_taxons
          Spree::Classification.where(:product => @product).where(:taxon => product_taxons).map{|t| t.delete}          
        end               
        @product.taxons << taxon          
      end 
    end

    def update_property property_name
      return if @product.blank?
      return if @tovar.blank?   
      ap @tovar   
      property_id = get_number property_name            
      property = Spree::Property.find_by_id(property_id) 
      if property.present?
      ap '*******update_property*'
      ap @tovar[property_name].strip
        Spree::ProductProperty.find_or_create_by(property: property, value: @tovar[property_name].strip, product: @product) if !@product.properties.include?(property)
      end  
    end

    def update_variant variant_name
      return if @product.blank?
      return if @tovar.blank?
      ap '****variant_name******'
    end

    def update_image
      return if @product.blank?
      return if @tovar.blank?
      return if @tovar['product::image'].blank?
      ap '*******update_image*******'
      ap @tovar['product::image']
    end

end
# encoding: utf-8
module WeixinAuthorize
  module Api
    module Poi


      INVOKE_POI_REQUIRED_FIELDS = %i(business_name branch_name
                                      province city district address
                                      telephone categories
                                      offset_type longitude latitude
                                      photo_list special open_time avg_price)
      # 创建门店
      # http://api.weixin.qq.com/cgi-bin/poi/addpoi?access_token=TOKEN
      def poi_add(params)
        params = {
            business_name: '',
            branch_name: '',
            province: '',
            city: '',
            district: '',
            address: '',
            telephone: '',
            categories: '',
            offset_type: 1, #火星坐标
            longitude: '',
            latitude: '',
            photo_list: [],
            special: '',
            open_time: '',
            avg_price: nil,
            sid: '',
            introduction: nil,
            recommend: nil,
        }.merge(params)
        check_required_options(params, INVOKE_POI_REQUIRED_FIELDS)
        post_body = {
            business: { base_info: params }
        }
        url = "#{poi_base_url}/addpoi"
        http_post(url, post_body)
      end

      INVOKE_POI_UPDATE_REQUIRED_FIELDS = %i(poi_id)
      # 修改门店
      # https://api.weixin.qq.com/cgi-bin/poi/updatepoi?access_token=TOKEN
      def poi_update(params)
        params = {
            poi_id: poi_id
        }.merge(params)
        check_required_options(params, INVOKE_POI_UPDATE_REQUIRED_FIELDS)
        post_body = {
            business: { base_info: params }
        }
        url = "#{poi_base_url}/updatepoi"
        http_post(url, post_body)
      end

      # 拉取门店类目表
      # http://api.weixin.qq.com/cgi-bin/api_getwxcategory?access_token=TOKEN
      def poi_category(poi_id='')
        url = "/api_getwxcategory"
        post_body = {
            poi_id: poi_id
        }
        http_post(url, post_body)
      end


      # 删除门店
      # https://api.weixin.qq.com/cgi-bin/poi/delpoi?access_token=TOKEN
      def poi_delete(poi_id='')
        url = "#{poi_base_url}/delpoi"
        post_body = {
            poi_id: poi_id
        }
        http_post(url, post_body)
      end

      # 查询门店信息
      # http://api.weixin.qq.com/cgi-bin/poi/getpoi?access_token=TOKEN
      def poi(poi_id='')
        url = "#{poi_base_url}/getpoi"
        post_body = {
            poi_id: poi_id
        }
        http_post(url, post_body)
      end


      # 查询门店列表
      # https://api.weixin.qq.com/cgi-bin/poi/getpoilist?access_token=TOKEN
      def pois(offset=0, limit=50)
        url = "#{poi_base_url}/getpoilist"
        post_body = {
            begin: offset,
            limit: limit
        }
        http_post(url, post_body)
      end

      private

        def poi_base_url
          "/poi"
        end

        def check_required_options(options, names)
          names.each do |name|
            warn("Weixin Poi: missing required param: #{name}") if options.nil? ||
                !options.has_key?(name) ||
                options[name].nil? ||
                (!options[name].is_a?(Integer) && options[name].empty?)
          end
        end

    end
  end
end

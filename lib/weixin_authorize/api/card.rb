# encoding: utf-8
# ===================
# 非 nil 参数为必填参数
# 传入参数必须为 Symbol
# ===================
module WeixinAuthorize
  # 考虑了一下由于 Client 本身会引入所有的API
  # 而 JsonHelper 不属于 API 部分
  # 所以还是把 JsonHelper 放在外层
  module CardJsonHelper
    # 创建卡券base_info json
    def sku(quantity=0)
      {
          quantity: quantity
      }
    end

    def date_info(type='', begin_timestamp=nil, end_timestamp=nil, fixed_term=nil, fixed_begin_term=nil)
      {
          type: type,
          begin_timestamp: begin_timestamp,
          end_timestamp:   end_timestamp,
          fixed_term: fixed_term,
          fixed_begin_term: fixed_begin_term
      }
    end

    def base_info
      (base_info = {
          logo_url: '',   code_type: '', brand_name: '',
          title: '',      sub_title: '', color: '',       notice: '',
          description: '',
          sku: { quantity: 0 },
          date_info: {type: '',
                      begin_timestamp: nil,
                      end_timestamp:  nil,
                      fixed_term: nil,
                      fixed_begin_term: nil},
          use_custom_code: nil, bind_openid: nil,
          service_phone: nil,   location_id_list: nil,
          source: nil,
          custom_url_name: nil,   custom_url: nil,      custom_url_sub_title: nil,
          promotion_url_name: nil, promotion_url: nil,  promotion_url_sub_title: nil,
          get_limit: nil,         can_share: nil,       can_give_friend: nil })
      base_info
    end

    class MemberCard
      # 创建自定义会员信息类目json
      # 会员卡激活后显示。
      def custom_cell(name_type='', tips='', url='')
        {
            name_type: name_type,
            tips: tips,
            url: url
        }
      end

      # 创建自定义会员信息类目json
      # 会员信息类目名称，取以下任一值：
      # name_type =
      # 等级	FIELD_NAME_TYPE_LEVEL
      # 印花	FIELD_NAME_TYPE_STAMP
      # 折扣	FIELD_NAME_TYPE_DISCOUNT
      # 成就	FIELD_NAME_TYPE_ACHIEVEMEN
      # 里程	FIELD_NAME_TYPE_MILEAGE
      # 优惠券	FIELD_NAME_TYPE_COUPON"
      def custom_field(name_type='', url='')
        {
            name_type: name_type,
            url: url
        }
      end

      def bonus(supply_bonus=false, bonus_url=nil, bonus_cleared=nil, bonus_rules=nil)
        {
            supply_bonus: supply_bonus,
            bonus_url: bonus_url,
            bonus_cleared: bonus_cleared,
            bonus_rules: bonus_rules
        }
      end

      def balance(supply_balance=false, balance_url=nil, balance_rules=nil)
        {
            supply_balance: supply_balance,
            balance_url: balance_url,
            balance_rules: balance_rules
        }
      end

      # 创建会员卡json
      def create(bash_info={}, options={
          activate_url: '',
          prerogative: '',
          bonus: { supply_bonus: false, bonus_url: nil, bonus_cleared: nil, bonus_rules: nil },
          balance: { supply_balance: false, balance_url: nil, balance_rules: nil },
          custom_field: [{name_type:'', url:''}], custom_cell: [{name_type: '', tips: '', url: ''}]
      })
        {card:{
            card_type: 'MEMBER_CARD',
            base_info: bash_info,
            activate_url: options[:activate_url],
            prerogative: options[:prerogative],
            supply_bonus: options[:bonus][:supply_bonus],
            bonus_url: options[:bonus][:bonus_url],
            bonus_cleared: options[:bonus][:bonus_cleared],
            bonus_rules: options[:bonus][:bonus_rules],
            supply_balance: options[:balance][:supply_balance],
            balance_url: options[:balance][:balance_url],
            balance_rules: options[:balance][:balance_rules],
            custom_field1: options[:custom_field[0]],
            custom_field2: options[:custom_field[1]],
            custom_field3: options[:custom_field[2]],
            custom_cell1: options[:custom_cell[0]]}
        }
      end
    end

    class Groupon
      # 创建团购券json
      def create(bash_info={}, options={
          deal_detail: ''
      })
        {card:{
            card_type: 'GROUPON',
            base_info: bash_info,
            deal_detail: options[:deal_detail]}
        }
      end
    end

    class Cash
      # 创建代金券json
      def create(bash_info={}, options={
          least_cost: 0,
          reduce_cost: 0})
        {card:{
            card_type: 'CASH',
            base_info: bash_info,
            least_cost: options[:least_cost],
            reduce_cost: options[:reduce_cost], }
        }
      end
    end

    class Discount
      # 创建折扣券json
      def create(bash_info={}, options={
          discount: 0})
        {card:{
            card_type: 'DISCOUNT',
            base_info: bash_info,
            discount: options[:discount]}
        }
      end
    end

    class Gift
      # 创建礼品券json
      def create(bash_info={}, options={
          gift: ''})
        {card:{
            card_type: 'DISCOUNT',
            base_info: bash_info,
            gift: options[:gift]}
        }
      end
    end

    class GeneralCoupon
      # 创建通用券json
      def create(bash_info={}, options={
          default_detail: ''
      })
        {card:{
            card_type: 'GENERAL_COUPON',
            base_info: bash_info,
            default_detail: options[:default_detail]
        }
        }
      end
    end

    class MeetingTicket
      # 创建会议门票json
      def create(bash_info={}, options={
          meeting_detail: '',
          map_url: nil})
        {card:{
            card_type: 'MEETING_TICKET',
            base_info: bash_info,
            meeting_detail: options[:meeting_detail],
            map_url: options[:map_url]}
        }
      end
    end

    class ScenicTicket
      # 创建景区门票json
      def create(bash_info={}, options={
          ticket_class: '',
          guide_url: ''})
        {card:{
            card_type: 'SCENIC_TICKET',
            base_info: bash_info,
            ticket_class: options[:ticket_class],
            guide_url: options[:guide_url]}
        }
      end
    end

    class BoardingPass
      # 创建飞机票json
      def create(bash_info={}, options={
          from: '',
          to: '',
          flight: '',
          gate: nil,
          check_in_url: nil,
          air_model: '',
          departure_time: '',
          landing_time: ''})
        {card:{
            card_type: 'BOARDING_PASS',
            base_info: bash_info,
            detail: options[:detail]}
        }
      end
    end

    class MovieTicket
      # 创建电影票json
      def create(bash_info={}, options={
          tickedetailt_class: ''})
        {card:{
            card_type: 'MOVIE_TICKET',
            base_info: bash_info,
            detail: options[:detail]}
        }
      end
    end





  end

  module Api
    module Card
      # 获取卡券配色方案列表
      # https://api.weixin.qq.com/card/getcolors?access_token=TOKEN
      def card_get_colors
        url = "#{card_base_url}/getcolors"
        http_post(url)
      end

      # 预览接口
      # https://api.weixin.qq.com/cgi-bin/message/mass/preview?access_token=ACCESS_TOKEN
      # 请使用 Symbol 传入
      # touser = option { openid: openid, wxname: wxname }
      # card_ext = {code:,openid:, timestamp:1402057159, signature:017bb17407c8e0058a66d72dcc61632b70f511ad}
      # !!!signature!!! 请使用 client.get_jssign_package['signature'] 传入
      def card_send_preview(touser='', card_id=[], signature='')
        url = "cgi-bin/message/mass/preview"
        card_ext_body =  {
            code: touser[:openid],
            timestamp: Time.now.to_i,
            signature: signature
        }
        wxcard_body = {
            card_id: card_id,
            card_ext: card_ext_body
        }
        post_body = {
            msgtype: 'wxcard',
            touser: touser[:openid],
            towxname: touser[:wxname],
            wxcard: wxcard_body
        }
        http_post(url, post_body)
      end

      # 统计卡券数据 - 拉取会员卡数据接口
      # https://api.weixin.qq.com/datacube/getcardmembercardinfo?access_token=ACCESS_TOKEN
      def card_datacube_info_member_card(begin_date=0, end_date=0, cond_source=1)
        url = "#{datacube_base_url}/getcardmembercardinfo"
        post_body = {
            begin_date: begin_date.strptime("%Y-%m-%d").to_s,
            end_date: end_date.strptime("%Y-%m-%d").to_s,
            cond_source: cond_source
        }
        http_post(url, post_body)
      end

      # 获取免费券数据接口
      # https://api.weixin.qq.com/datacube/getcardcardinfo?access_token=ACCESS_TOKEN
      def card_datacube_info(begin_date=0, end_date=0, cond_source=1, card_id=nil)
        url = "#{datacube_base_url}/getcardcardinfo"
        post_body = {
            begin_date: begin_date.strptime("%Y-%m-%d").to_s,
            end_date: end_date.strptime("%Y-%m-%d").to_s,
            cond_source: cond_source,
            card_id: card_id
        }
        http_post(url, post_body)
      end

      # 拉取卡券概况数据接口
      # https://api.weixin.qq.com/datacube/getcardbizuininfo?access_token=ACCESS_TOKEN
      def card_datacube(begin_date=0, end_date=0, cond_source=1)
        url = "#{datacube_base_url}/getcardbizuininfo"
        post_body = {
            begin_date: begin_date.strptime("%Y-%m-%d").to_s,
            end_date: end_date.strptime("%Y-%m-%d").to_s,
            cond_source: cond_source
        }
        http_post(url, post_body)
      end

      # 设置测试白名单
      # https://api.weixin.qq.com/card/testwhitelist/set?access_token=TOKEN
      def card_testwhitelist(openid=[], wxusername=[])
        url = "#{card_base_url}/testwhitelist"
        post_body = {
            openid: openid[0, 9], # 微信接口限制10个白名单用户，多余的抛弃
            username: wxusername[0,9] # 微信接口限制10个白名单用户，多余的抛弃
        }
        http_post(url, post_body)
      end

      # 图文消息群发卡券
      # https://api.weixin.qq.com/card/mpnews/gethtml?access_token=TOKEN
      def card_code_mpnews(card_id=nil)
        url = "#{card_base_url}/code/mpnews/gethtml"
        post_body = {
            card_id: card_id
        }
        http_post(url, post_body)
      end

      # 核查code接口
      # http://api.weixin.qq.com/card/code/checkcode?access_token=ACCESS_TOKEN
      def card_code_checkcode(card_id='', codelist='')
        url = "#{card_base_url}/code/checkcode"
        post_body = {
            card_id: card_id,
            code: codelist
        }
        http_post(url, post_body)
      end

      # 导入code接口
      # http://api.weixin.qq.com/card/code/deposit?access_token=ACCESS_TOKEN
      # codelist = ['11111', '22222', '33333']
      def card_code_deposit(card_id='', codelist=[])
        url = "#{card_base_url}/code/deposit"
        post_body = {
            card_id: card_id,
            code: codelist
        }
        http_post(url, post_body)
      end

      # 创建货架接口
      # https://api.weixin.qq.com/card/landingpage/create?access_token=$TOKEN
      #
      # 场景值 scene
      # SCENE_NEAR_BY 附近
      # SCENE_SCAN	扫一扫
      # SCENE_SHAKE_TV	摇电视
      # SCENE_WIFI 微信wifi
      # SCENE_IBEACON	iBeacon
      # SCENE_PAY	微信支付
      # SCENE_MENU	自定义菜单
      # SCENE_MONENTS_AD 朋友圈广告
      # SCENE_QRCODE	二维码
      # SCENE_ARTICLE	公众号文章
      # SCENE_H5	h5页面
      # SCENE_SHAKE_CARD 摇礼券
      # SCENE_BIZ_AD	公众号广告
      # SCENE_IVR	自动回复
      # SCENE_SMS	短信
      # SCENE_MEMBER_CARD_ANNOUNCEMENT 会员卡公告
      # SCENE_CARD_CUSTOM_CELL	卡券自定义cell
      # SCENE_CARD_MSG_URL 卡券消息运营位
      #
      def card_landingpage(banner='', title='', can_share=false, scene='', cardlist=[{cardid: cardid, thumb_url: thumb_url}])
        url = "#{card_base_url}/landingpage/create"
        post_body = {
            banner: banner,
            title: title,
            can_share: can_share,
            scene: scene,
            cardlist: cardlist
        }
        http_post(url, post_body)
      end

      # 创建二维码接口
      # https://api.weixin.qq.com/card/qrcode/create?access_token=TOKEN
      def card_code_qrcode(card_id='', code=nil, openid=nil,
                           expire_seconds=nil,   is_unique_code=nil, outer_id=nil)
        url = "#{card_base_url}/code/qrcode/create"
        card_body = {
            card_id: card_id,
            code: code,
            openid: openid,
            is_unique_code: is_unique_code,
            outer_id: outer_id
        }
        post_body = {
            action_name: 'QR_CARD',
            expire_seconds: expire_seconds,
            action_info: card_body
        }
        http_post(url, post_body)
      end

      # Code解码接口
      # https://api.weixin.qq.com/card/code/decrypt?access_token=TOKEN
      def card_code_decrypt(encrypt_code='')
        url = "#{card_base_url}/code/decrypt"
        post_body = {
            encrypt_code: encrypt_code
        }
        http_post(url, post_body)
      end

      # 核销Code接口
      # https://api.weixin.qq.com/card/code/consume?access_token=TOKEN
      def card_code_consume(card_id=nil, code='')
        url = "#{card_base_url}/code/consume"
        post_body = {
            card_id: card_id,
            code: code
        }
        http_post(url, post_body)
      end


      # 设置卡券失效接口
      # https://api.weixin.qq.com/card/code/unavailable?access_token=TOKEN
      def card_code_unavailable(card_id=nil, code='')
        url = "#{card_base_url}/code/unavailable"
        post_body = {
            card_id: card_id,
            code: code
        }
        http_post(url, post_body)
      end

      # 删除卡券接口
      # https://api.weixin.qq.com/card/delete?access_token=TOKEN
      def card_delete(card_id='')
        url = "#{card_base_url}/delete"
        post_body = {
            card_id: card_id
        }
        http_post(url, post_body)
      end


      # 更改Code接口
      # https://api.weixin.qq.com/card/code/update?access_token=TOKEN
      def card_code_update(card_id=nil, code='', new_code='')
        url = "#{card_base_url}/code/update"
        post_body = {
            card_id: card_id,
            code: code,
            new_code: new_code
        }
        http_post(url, post_body)
      end

      # 修改库存接口
      # https://api.weixin.qq.com/card/modifystock?access_token=TOKEN
      def card_modifystock(card_id='', increase_stock_value=nil, reduce_stock_value=nil)
        url = "#{card_base_url}/modifystock"
        post_body = {
            card_id: card_id,
            increase_stock_value: increase_stock_value,
            reduce_stock_value: reduce_stock_value
        }
        http_post(url, post_body)
      end

      # 更改卡券信息接口
      # https://api.weixin.qq.com/card/update?access_token=TOKEN
      def card_update(card_id='', card={})
        card = card[:card] if !card[:card].nil?
        card[:card_id] = card_id
        url = "#{card_base_url}/update"
        http_post(url, card)
      end

      # 批量查询卡列表
      # https://api.weixin.qq.com/card/batchget?access_token=TOKEN
      # offset => 查询卡列表的起始偏移量，从0开始，即offset: 5是指从从列表里的第六个开始读取。
      # count => 需要查询的卡片的数量（数量最大50）。
      # status_list => 支持开发者拉出指定状态的卡券列表，例：仅拉出通过审核的卡券。

      # 卡券状态
      # CARD_STATUS_NOT_VERIFY    待审核
      # CARD_STATUS_VERIFY_FALL   审核失败
      # CARD_STATUS_VERIFY_OK     通过审核
      # CARD_STATUS_USER_DELETE   卡券被用户删除
      # CARD_STATUS_USER_DISPATCH 在公众平台投放过的卡券

      def card_batchget(offset=0, count=50, status_list=['CARD_STATUS_USER_DISPATCH'])
        url = "#{card_base_url}/batchget"
        post_body = {
            offset: offset,
            count: count,
            status_list: status_list
        }
        http_post(url, post_body)
      end

      # 查看卡券详情
      # https://api.weixin.qq.com/card/get?access_token=TOKEN
      def card_get(card_id='')
        url = "#{card_base_url}/get"
        post_body = {
            card_id: card_id
        }
        http_post(url, post_body)
      end

      # 获取用户已领取卡券接口
      # https://api.weixin.qq.com/card/user/getcardlist?access_token=TOKEN
      def card_user_getcardlist(openid='', card_id=nil)
        url = "#{card_base_url}user/getcardlist"
        post_body = {
            openid: openid,
            card_id: card_id
        }
        http_post(url, post_body)
      end


      # 查询Code
      # https://api.weixin.qq.com/card/code/get?access_token=TOKEN
      def card_code_get(code='')
        url = "#{card_base_url}/code/get"
        post_body = {
            code: code
        }
        http_post(url, post_body)
      end

      # 更新会议门票
      # https://api.weixin.qq.com/card/meetingticket/updateuser?access_token=TOKEN
      def card_meeting_ticket_update_user(options = {code: '', card_id: nil,
                                        begin_time: nil, end_time: nil, zone: '', entrance: '', seat_number: ''})
        url = "#{card_base_url}/meetingticket/updateuser"
        post_body = {
            code:         options[:code],
            card_id:      options[:card_id],
            begin_time:   options[:begin_time],
            end_time:     options[:end_time],
            zone:         options[:zone],
            entrance:     options[:entrance],
            seat_number:  options[:seat_number]
        }
        http_post(url, post_body)
      end

      # 更新电影票
      # https://api.weixin.qq.com/card/movieticket/updateuser?access_token=TOKEN
      def card_moive_ticket_update_user(options = {code: '', card_id: '',
                                                   ticket_class: '', screening_room: nil, seat_number: nil, show_time: 0, duration: 0})
        url = "#{card_base_url}/movieticket/updateuser"
        post_body = {
            code:           options[:code],
            card_id:        options[:card_id],
            ticket_class:   options[:ticket_class],
            screening_room: options[:screening_room],
            seat_number:    options[:seat_number],
            show_time:      options[:show_time],
            duration:       options[:duration]
        }
        http_post(url, post_body)
      end

      # 更新飞机票信息
      # https://api.weixin.qq.com/card/boardingpass/checkin?access_token=TOKEN
      def card_boarding_pass_check_in(options = {code: '', card_id: nil,
                                                 passenger_name: '', class: '', seat: nil, etkt_bnr: 0, qrcode_data: nil, is_cancel: nil})
        url = "#{card_base_url}/boardingpass/checkin"
        post_body = {
            code:        options[:code],
            card_id:     options[:card_id],
            etkt_bnr:    options[:etkt_bnr],
            class:       options[:class],
            qrcode_data: options[:qrcode_data],
            seat:        options[:seat],
            is_cancel:   options[:is_cancel]
        }
        http_post(url, post_body)
      end

      # 微信卡券创建接口
      # https://api.weixin.qq.com/card/create?access_token=ACCESS_TOKEN
      def card_create(card)
        card = JSON.load(card) if card.is_a?(String)
        url = "#{card_base_url}/create"
        http_post(url, card)
      end

      private
        def datacube_base_url
          "/datacube"
        end

        def card_base_url
          "/card"
        end

    end
  end
end

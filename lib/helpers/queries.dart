const AUTH_USER=''' 
 user {
            id
            name
            is_verified
id_color
info
open_time
close_time
total_views
            seller_name
            email_verified_at
            email
            level
            address
            phone
            is_seller
            image
            logo
            total_balance
            total_point
            following_count
            plans{
            id
            pivot{
             expired_date
            }
            }
             city {
                name
                id
            }
            social{
              twitter
              face
              instagram
              linkedin
              tiktok
            }
            followers {
                seller{
                
                id
              
                }
            }
        }
''';

const AUTH_FIELDS='''
            id
            name
           open_time
close_time
total_views
            seller_name
            email_verified_at
            email
            level
            is_verified
            id_color
            social{
              twitter
              face
              instagram
              linkedin
              tiktok
            }
            address
            phone
            image
            logo
            info
            following_count
            total_balance
            total_point
            is_seller
            plans{
            id
            pivot{
             expired_date
            }
            }
            
             city {
                name
                id
            }
            followers {
                seller{
               
                id
            
                }
            }
''';
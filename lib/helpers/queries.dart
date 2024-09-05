const AUTH_USER=''' 
 user {
            id
            name
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
            seller_name
            email_verified_at
            email
            level
            address
            phone
            image
            logo
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
            }
            followers {
                seller{
               
                id
            
                }
            }
''';
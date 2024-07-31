const AUTH_USER=''' 
 user {
            id
            name
            seller_name
            email_verified_at
            email
            level
            address
            image
            logo
            total_balance
            total_point
            following_count
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
            image
            logo
            following_count
            total_balance
            total_point
             city {
                name
            }
            followers {
                seller{
               
                id
            
                }
            }
''';
//
//  FoodTracker
//
//  Created by Jane Appleseed on 5/26/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//  See LICENSE.txt for this sample’s licensing information.
//

import UIKit

class User {
    // MARK: Properties
    
    var name: String
    var photo: UIImage?

    // MARK: Initialization
    
    init?(name: String, photo: UIImage?) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty{
            return nil
        }
    }
    
    func getUsername() -> String
    {
        return (name)
    }
    
    

}
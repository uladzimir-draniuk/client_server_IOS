//
//  VKPhoto.swift
//  less_1_IOS
//
//  Created by elf on 20.04.2021.
//

import Foundation
import SwiftyJSON


class VKPhoto {
    let id: Int
    let ownerId: Int
    var photos = [VKPhotoSizes]()

    init(json: JSON) {
        self.id = json["id"].intValue
        self.ownerId = json["owner_id"].intValue
    }
}

class VKPhotoSizes {
    let type: String
    private let photoUrlString : String
    
    var photoUrl: URL? { URL(string: photoUrlString) }
    
    init(json: JSON) {
        self.type = json["type"].stringValue
        self.photoUrlString = json["url"].stringValue
    }
}


//json = {
//    response =     {
//        count = 49;
//        items =         (
//                        {
//                "album_id" = "-7";
//                date = 1424187446;
//                "has_tags" = 0;
//                id = 354580807;
//                "owner_id" = 136709529;
//                sizes =                 (
//                                        {
//                        height = 97;
//                        type = m;
//                        url = "https://sun9-57.userapi.com/impf/c623127/v623127529/1b79f/MdWd6E_Ykgc.jpg?size=130x97&quality=96&sign=4b0559735383f99b4132569aff28a311&c_uniq_tag=DkFYnF2MduoEHCGZBtVj3sZnDyk4JReX3zJzoxTDnIk&type=album";
//                        width = 130;
//                    },
//                                        {
//                        height = 98;
//                        type = o;
//                        url = "https://sun9-57.userapi.com/impf/c623127/v623127529/1b79f/MdWd6E_Ykgc.jpg?size=130x97&quality=96&sign=4b0559735383f99b4132569aff28a311&c_uniq_tag=DkFYnF2MduoEHCGZBtVj3sZnDyk4JReX3zJzoxTDnIk&type=album";
//                        width = 130;
//                    },
//                                        {
//                        height = 150;
//                        type = p;
//                        url = "https://sun9-57.userapi.com/impf/c623127/v623127529/1b79f/MdWd6E_Ykgc.jpg?size=200x150&quality=96&sign=7e0f9c73e0881015656eb20e06a9d885&c_uniq_tag=1O8OG6J2oMeZpi4cIBgY4PJvnvFOo3Iyot92KzAnf2Y&type=album";
//                        width = 200;
//                    },
//                                        {
//                        height = 240;
//                        type = q;
//                        url = "https://sun9-57.userapi.com/impf/c623127/v623127529/1b79f/MdWd6E_Ykgc.jpg?size=320x240&quality=96&sign=b6a1c75967ee33a7b284f07484ec5f8b&c_uniq_tag=arN4FLUQBXY-pkTzMtak01MhtZ1IEOhzov69WCWm7N4&type=album";
//                        width = 320;
//                    },
//                                        {
//                        height = 383;
//                        type = r;
//                        url = "https://sun9-57.userapi.com/impf/c623127/v623127529/1b79f/MdWd6E_Ykgc.jpg?size=510x382&quality=96&sign=3ffafedb6633a69ef57f9685d79b51f9&c_uniq_tag=rLJEneRR7CyKLnxkoqwyZkXWxHuYWPdv-kRevhanVRM&type=album";
//                        width = 510;
//                    },
//                                        {
//                        height = 56;
//                        type = s;
//                        url = "https://sun9-57.userapi.com/impf/c623127/v623127529/1b79f/MdWd6E_Ykgc.jpg?size=75x56&quality=96&sign=c9262b4c080e437d8c57c9d02b7ebac0&c_uniq_tag=Kw7W6A_mZwTEelLCyZWoOu2y6ft_g_eHVLDA5POv0vA&type=album";
//                        width = 75;
//                    },
//                                        {
//                        height = 453;
//                        type = x;
//                        url = "https://sun9-57.userapi.com/impf/c623127/v623127529/1b79f/MdWd6E_Ykgc.jpg?size=604x453&quality=96&sign=cb3ab0bc36e878d2e7e714c845232db6&c_uniq_tag=qLLmcS8SvxIXCRouADAMqDquZvsxhK5WPJKAdDAcIHc&type=album";
//                        width = 604;
//                    },
//                                        {
//                        height = 600;
//                        type = y;
//                        url = "https://sun9-57.userapi.com/impf/c623127/v623127529/1b79f/MdWd6E_Ykgc.jpg?size=800x600&quality=96&sign=ae1e377bb448f2c274641f54507b0cb0&c_uniq_tag=2MclO61ixb0u0lBiQvwrK6UlHSDDa1VeBShoDCwHPVM&type=album";
//                        width = 800;
//                    }
//                );
//                text = "";
//            },
//                        {
//                "album_id" = "-7";
//                date = 1457784035;
//                "has_tags" = 0;
//                id = 406030975;
//                "owner_id" = 136709529;
//                sizes =                 (
//                                        {
//                        height = 130;
//                        type = m;
//                        url = "https://sun9-49.userapi.com/impf/c628023/v628023529/42dc2/FvR46W6EYDU.jpg?size=97x130&quality=96&sign=ccbf63294a98209e3c238ac7445d2ea9&c_uniq_tag=PjPUbCtHFlDLTdYIo9LsJsWcS3tP17vMq52Ue_Fe_pM&type=album";
//                        width = 97;
//                    },
//                                        {
//                        height = 173;
//                        type = o;
//                        url = "https://sun9-49.userapi.com/impf/c628023/v628023529/42dc2/FvR46W6EYDU.jpg?size=130x173&quality=96&sign=925860b5e6e075c9f4980c59deced22e&c_uniq_tag=YklCC-HsAzMLkIwFXpH3S4zb5Pd4ci_A6wXYwvnPN4Q&type=album";
//                        width = 130;
//                    },
//                                        {
//                        height = 267;
//                        type = p;
//                        url = "https://sun9-49.userapi.com/impf/c628023/v628023529/42dc2/FvR46W6EYDU.jpg?size=200x267&quality=96&sign=5f69c160da094ae2654f1619cf839610&c_uniq_tag=ZLFGO4nd_8qgv8AnI0SaProXXYbmM4j2dkKG4Jdlerc&type=album";
//                        width = 200;
//                    },
//                                        {
//                        height = 427;
//                        type = q;
//                        url = "https://sun9-49.userapi.com/impf/c628023/v628023529/42dc2/FvR46W6EYDU.jpg?size=320x427&quality=96&sign=6408a179e6a68d225e9971daa5e6db41&c_uniq_tag=-vLe9oRfmBNKiwjzLVc_hRwcn9NjTNtPjNvh4g2DtR0&type=album";
//                        width = 320;
//                    },
//                                        {
//                        height = 680;
//                        type = r;
//                        url = "https://sun9-49.userapi.com/impf/c628023/v628023529/42dc2/FvR46W6EYDU.jpg?size=510x680&quality=96&sign=3b5c8a07143ff08304b76f44237427e1&c_uniq_tag=wjgKdWi7CtcFT-ODIDk5gGbR34ZIvU0oMuD1nAPgG0k&type=album";
//                        width = 510;
//                    },
//                                        {
//                        height = 75;
//                        type = s;
//                        url = "https://sun9-49.userapi.com/impf/c628023/v628023529/42dc2/FvR46W6EYDU.jpg?size=56x75&quality=96&sign=d7ca2ea9e2c6a76ef13d9d3e98e0bb77&c_uniq_tag=sWc81DQfZdw-PqdPG1LTg1Oy5ltywZiNDLn0uSYGJL4&type=album";
//                        width = 56;
//                    },
//                                        {
//                        height = 1632;
//                        type = w;
//                        url = "https://sun9-49.userapi.com/impf/c628023/v628023529/42dc2/FvR46W6EYDU.jpg?size=1224x1632&quality=96&sign=78bfcff394a7dc3f8af5c03052a4a576&c_uniq_tag=70wKP9CBHHwCjdllaujlxmbEifvO4qm6QAcsg3fDWG0&type=album";
//                        width = 1224;
//                    },
//                                        {
//                        height = 604;
//                        type = x;
//                        url = "https://sun9-49.userapi.com/impf/c628023/v628023529/42dc2/FvR46W6EYDU.jpg?size=453x604&quality=96&sign=79b16cefb46bd6881c60e51afa378d3e&c_uniq_tag=YjadAhhNlRCVNxelfY-HfJqnRCU1vBwEfE_Uc676NW8&type=album";
//                        width = 453;
//                    },
//                                        {
//                        height = 807;
//                        type = y;
//                        url = "https://sun9-49.userapi.com/impf/c628023/v628023529/42dc2/FvR46W6EYDU.jpg?size=605x807&quality=96&sign=c4c27b4fec5824cb40b72e87f70121b5&c_uniq_tag=d4jIJPBuqtjykw-6W5N-1po1FccXMDf_AzMKVnX-nTY&type=album";
//                        width = 605;
//                    },
//                                        {
//                        height = 1080;
//                        type = z;
//                        url = "https://sun9-49.userapi.com/impf/c628023/v628023529/42dc2/FvR46W6EYDU.jpg?size=810x1080&quality=96&sign=c2da0b6445c7bcb68941d8af7617e97b&c_uniq_tag=G5dqN5gto8yvTjGV5W8YxBdOlzFFmLRgmRfBkrY9e3E&type=album";
//                        width = 810;
//                    }
//                );
//                text = "";
//            },
//                        {
//                "album_id" = "-7";
//                date = 1459678813;
//                "has_tags" = 0;
//                id = 409254860;
//                "owner_id" = 136709529;
//                sizes =

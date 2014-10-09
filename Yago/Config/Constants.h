//
//  Constants.h
//  Yago
//
//  Created by Macbook on 30/09/14.
//  Copyright (c) 2014 koombea. All rights reserved.
//

//iOS version

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define PARSE_EVENT @"Event"
#define PARSE_REPORT @"Report"
#define PARSE_PARTICIPANTS @"Participants"
#define TIME -100000


#define DEFAULT_LATITUDE 11.00416598076192
#define DEFAULT_LONGITUDE -74.80820097170515
#define MAP_ZOOM 12

#define REPORT_TABLE_TITLE @"Reportes"


//Mensajes
#define LOCATION_NOT_AVAILABLE_TITLE @"Ubicación no disponible"
#define LOCATION_NOT_AVAILABLE_DESCRIPTION @"Intentamos saber donde estas para mostrarte información precisa, pero no fue posible. Verifica los permisos que tenemos en Ajustes/Privacidad/Localización "

#define TEXTVIEW_PLACEHOLDER @"Escribe aquí tu comentario"

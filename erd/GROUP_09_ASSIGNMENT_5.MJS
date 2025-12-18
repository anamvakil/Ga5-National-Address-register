erDiagram

    GA5_Street {
        int    StreetID
        string OFFICIAL_STREET_NAME
        string OFFICIAL_STREET_TYPE
        string OFFICIAL_STREET_DIR
    }

    GA5_Municipality {
        int    MunicipalityID
        string CSD_ENG_NAME
        string CSD_FRE_NAME
        string CSD_TYPE_ENG_CODE
        string CSD_TYPE_FRE_CODE
    }

    GA5_Province {
        int    ProvinceID
        string PROV_CODE
        string MAIL_PROV_ABVN
    }

    GA5_Geography {
        int    GeographyID
        string BG_DLS_LSD
        string BG_DLS_QTR
        string BG_DLS_SCTN
        string BG_DLS_TWNSHP
        string BG_DLS_RNG
        string BG_DLS_MRD
        string BG_X
        string BG_Y
    }

    GA5_MailingAddress {
        int    MailingID
        string MAIL_STREET_NAME
        string MAIL_STREET_TYPE
        string MAIL_STEET_DIR
        string MAIL_MUN_NAME
        string MAIL_POSTAL_CODE
    }

    GA5_AddressNormalized {
        int    AddressID
        string LOC_GUID
        string ADDR_GUID
        string APT_NO_LABEL
        string CIVIC_NO
        string CIVIC_NO_SUFFIX
        int    StreetID
        int    MunicipalityID
        int    ProvinceID
        int    GeographyID
        int    MailingID
        string BU_N_CIVIC_ADD
        string BU_USE
    }

    GA5_Street         ||--o{ GA5_AddressNormalized : "StreetID"
    GA5_Municipality   ||--o{ GA5_AddressNormalized : "MunicipalityID"
    GA5_Province       ||--o{ GA5_AddressNormalized : "ProvinceID"
    GA5_Geography      ||--o{ GA5_AddressNormalized : "GeographyID (optional)"
    GA5_MailingAddress ||--o{ GA5_AddressNormalized : "MailingID (optional)"

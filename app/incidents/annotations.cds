using ProcessorService as service from '../../srv/services';
using from '../../db/schema';


annotate service.Incidents with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Urgency}',
                Value: urgency_code,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Status}',
                Value: status_code,
            },
        ],
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>Overview}',
            ID    : 'i18nOverview',
            Facets: [{
                $Type : 'UI.ReferenceFacet',
                Label : '{i18n>Details}',
                ID    : 'i18nDetails',
                Target: '@UI.FieldGroup#i18nDetails',
            }, ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Conversation',
            ID    : 'Conversation',
            Target: 'conversation/@UI.LineItem#Conversation',
        },
    ],
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Value: title,
            Label: '{i18n>Title}',
        },
        {
            $Type: 'UI.DataField',
            Value: customer.name,
            Label: '{i18n>Customer}',
        },
        {
            $Type      : 'UI.DataField',
            Value      : status.descr,
            Criticality: status.criticality,
            Label      : '{i18n>Status}',
        },
        {
            $Type: 'UI.DataField',
            Value: urgency.descr,
            Label: '{i18n>Urgency}',
        },
    ],
    UI.SelectionFields           : [
        status_code,
        urgency_code,
    ],
    UI.FieldGroup #i18nDetails   : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: customer_ID,
                Label: '{i18n>Customer}',
            },
            {
                $Type: 'UI.DataField',
                Value: title,
                Label: '{i18n>Title}',
            },
        ],
    },
);


annotate service.Incidents with @(UI.HeaderInfo: {
    Title         : {
        $Type: 'UI.DataField',
        Value: title,
    },
    TypeName      : '',
    TypeNamePlural: '',
    Description   : {
        $Type: 'UI.DataField',
        Value: customer.name,
    },
    TypeImageUrl  : 'sap-icon://alert',
});

annotate service.Incidents with {
    customer @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Customers',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: customer_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'email',
                },
            ],
        },
        Common.Text                    : {
            $value                : customer.name,
            ![@UI.TextArrangement]: #TextOnly
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.Incidents with {
    status @(
        Common.Label                   : '{i18n>Status}',
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.Incidents with {
    urgency @(
        Common.Label                   : '{i18n>Urgency}',
        Common.Text                    : urgency.descr,
        UI.MultiLineText               : false,
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.Status with {
    code @Common.Text: descr
};

annotate service.Urgency with {
    code @Common.Text: descr
};

annotate service.Incidents.conversation with @(UI.LineItem #Conversation: [
    {
        $Type: 'UI.DataField',
        Value: author,
        Label: '{i18n>Author}',
    },
    {
        $Type: 'UI.DataField',
        Value: message,
        Label: '{i18n>Message}',
    },
    {
        $Type: 'UI.DataField',
        Value: timestamp,
        Label: '{i18n>Date}',
    },
]);

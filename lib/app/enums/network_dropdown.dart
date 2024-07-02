// ignore_for_file: constant_identifier_names

List<String> networkProviders = [
  'mtn',
  'glo',
  'airtel',
  '9mobile',
];

final Map<int, String> durationMap = {
    1: 'Daily',
    7: 'Weekly',
    30: 'Monthly',
    90: '3 Months',
    365: 'Yearly',
  };


// for(var product in networkProvider){
//  getDurationText(networkProvider['duration'])
// }
// function getDurationText(days) {
//   switch (parseInt(days)) {
//     case 1:
//       return "Daily";
//     case 7:
//       return "Weekly";
//     case 30:
//     case 31:
//       return "Monthly";
//     default:
//       return `${days} days`;
//   }
// }



List<String> selectUser = [
  'Vendor',
  'Customer',
];

List<String> services = [
  'Airtime',
  'Data',
];

List<String> dataPrices = [
  '1GB',
  '2GB - 5GB',
  '6GB - 10GB',
  '10GB - 15GB',
  '16GB - 20GB',
  '25GB & more',
];

List<String> dataValidityProvider = [
  'Daily',
  'Weekly',
  'Monthly',
  '3 Months',
  'Yearly',
];



// List<String> dataBundle = [
//   'MTN - 5GB - NGN 1500',
//   'MTN - 10GB - NGN 4000',
//   'MTN - 20GB - NGN 6000',
//   'MTN - 30GB - NGN 7000',
// ];

Map<String, List<String>> dataBundles = {
  'mtn': [
    'MTN - 5GB - NGN 1500',
    'MTN - 10GB - NGN 4000',
    'MTN - 20GB - NGN 6000',
    'MTN - 30GB - NGN 7000',
  ],
  'glo': [
    'GLO - 5GB - NGN 1500',
    'GLO - 10GB - NGN 4000',
    'GLO - 20GB - NGN 6000',
    'GLO - 30GB - NGN 7000',
  ],
  'airtel': [
    'Airtel - 5GB - NGN 1500',
    'Airtel - 10GB - NGN 4000',
    'Airtel - 20GB - NGN 6000',
    'Airtel - 30GB - NGN 7000',
  ],
  '9mobile': [
    '9mobile - 5GB - NGN 1500',
    '9mobile - 10GB - NGN 4000',
    '9mobile - 20GB - NGN 6000',
    '9mobile - 30GB - NGN 7000',
  ],
};

// Written in 2013 by Dmitry Chestnykh.
//
// To the extent possible under law, the author have dedicated all copyright
// and related and neighboring rights to this software to the public domain
// worldwide. This software is distributed without any warranty.
// http://creativecommons.org/publicdomain/zero/1.0/

import 'package:crypto/crypto.dart';
import 'package:unittest/unittest.dart';
import '../lib/blake2.dart';

main() {
  test('BLAKE2s', () {
    var golden = [
      "69217a3079908094e11121d042354a7c1f55b6482ca1a51e1b250dfd1ed0eef9",
      "e34d74dbaf4ff4c6abd871cc220451d2ea2648846c7757fbaac82fe51ad64bea",
      "ddad9ab15dac4549ba42f49d262496bef6c0bae1dd342a8808f8ea267c6e210c",
      "e8f91c6ef232a041452ab0e149070cdd7dd1769e75b3a5921be37876c45c9900",
      "0cc70e00348b86ba2944d0c32038b25c55584f90df2304f55fa332af5fb01e20",
      "ec1964191087a4fe9df1c795342a02ffc191a5b251764856ae5b8b5769f0c6cd",
      "e1fa51618d7df4eb70cf0d5a9e906f806e9d19f7f4f01e3b621288e4120405d6",
      "598001fafbe8f94ec66dc827d012cfcbba2228569f448e89ea2208c8bf769293",
      "c7e887b546623635e93e0495598f1726821996c2377705b93a1f636f872bfa2d",
      "c315a437dd28062a770d481967136b1b5eb88b21ee53d0329c5897126e9db02c",
      "bb473deddc055fea6228f207da575347bb00404cd349d38c18026307a224cbff",
      "687e1873a8277591bb33d9adf9a13912efefe557cafc39a7952623e47255f16d",
      "1ac7ba754d6e2f94e0e86c46bfb262abbb74f450ef456d6b4d97aa80ce6da767",
      "012c97809614816b5d9494477d4b687d15b96eb69c0e8074a8516f31224b5c98",
      "91ffd26cfa4da5134c7ea262f7889c329f61f6a657225cc212f40056d986b3f4",
      "d97c828d8182a72180a06a78268330673f7c4e0635947c04c02323fd45c0a52d",
      "efc04cdc391c7e9119bd38668a534e65fe31036d6a62112e44ebeb11f9c57080",
      "992cf5c053442a5fbc4faf583e04e50bb70d2f39fbb6a503f89e56a63e18578a",
      "38640e9f21983e67b539caccae5ecf615ae2764f75a09c9c59b76483c1fbc735",
      "213dd34c7efe4fb27a6b35f6b4000d1fe03281af3c723e5c9f94747a5f31cd3b",
      "ec246eeeb9ced3f7ad33ed28660dd9bb0732513db4e2fa278b60cde3682a4ccd",
      "ac9b61d446648c3005d7892bf3a8719f4c8181cfdcbc2b79fef10a279b911095",
      "7bf8b22959e34e3a43f7079223e83a9754617d391e213dfd808e41b9bead4ce7",
      "68d4b5d4fa0e302b64ccc5af792913ac4c88ec95c07ddf40694256eb88ce9f3d",
      "b2c2420f05f9abe36315919336b37e4e0fa33ff7e76a492767006fdb5d935462",
      "134f61bbd0bbb69aed5343904551a3e6c1aa7dcdd77e903e7023eb7c60320aa7",
      "4693f9bff7d4f3986a7d176e6e06f72ad1490d805c99e25347b8de77b4db6d9b",
      "853e26f741953b0fd5bdb424e8ab9e8b3750eaa8ef61e47902c91e554e9c73b9",
      "f7de536361abaa0e158156cf0ea4f63a99b5e4054f8fa4c9d45f6285cad55694",
      "4c230608860a99ae8d7bd5c2cc17fa52096b9a61bedb17cb7617864ad29ca7a6",
      "aeb920ea87952dadb1fb759291e3388139a872865001886ed84752e93c250c2a",
      "aba4ad9b480b9df3d08ca5e87b0c2440d4e4ea21224c2eb42cbae469d089b931",
      "05825607d7fdf2d82ef4c3c8c2aea961ad98d60edff7d018983e21204c0d93d1",
      "a742f8b6af82d8a6ca2357c5f1cf91defbd066267d75c048b352366585025962",
      "2bcac89599000b42c95ae23835a713704ed79789c84fef149a874ff733f017a2",
      "ac1ed07d048f105a9e5b7ab85b09a492d5baff14b8bfb0e9fd789486eea2b974",
      "e48d0ecfaf497d5b27c25d99e156cb0579d440d6e31fb62473696dbf95e010e4",
      "12a91fadf8b21644fd0f934f3c4a8f62ba862ffd20e8e961154c15c13884ed3d",
      "7cbee96e139897dc98fbef3be81ad4d964d235cb12141fb66727e6e5df73a878",
      "ebf66abb597ae572a7297cb0871e355accafad8377b8e78bf164ce2a18de4baf",
      "71b933b07e4ff7818ce059d008829e453c6ff02ec0a7db393fc2d870f37a7286",
      "7cf7c51331220b8d3ebaed9c29398a16d98156e2613cb088f2b0e08a1be4cf4f",
      "3e41a108e0f64ad276b979e1ce068279e16f7bc7e4aa1d211e17b81161df1602",
      "886502a82ab47ba8d86710aa9de3d46ea65c47af6ee8de450cceb8b11b045f50",
      "c021bc5f0954fee94f46ea09487e10a84840d02f64810bc08d9e551f7d416814",
      "2030516e8a5fe19ae79c336fce26382a749d3fd0ec91e537d4bd2358c12dfb22",
      "556698dac8317fd36dfbdf25a79cb112d5425860605cbaf507f23bf7e9f42afe",
      "2f867ba67773fdc3e92fced99a6409ad39d0b880fde8f109a81730c4451d0178",
      "172ec218f119dfae98896dff29dd9876c94af87417f9ae4c7014bb4e4b96afc7",
      "3f85814a18195f879aa962f95d26bd82a278f2b82320218f6b3bd6f7f667a6d9",
      "1b618fbaa566b3d498c12e982c9ec52e4da85a8c54f38f34c090394f23c184c1",
      "0c758fb5692ffd41a3575d0af00cc7fbf2cbe5905a58323a88ae4244f6e4c993",
      "a931360cad628c7f12a6c1c4b753b0f4062aef3ce65a1ae3f19369dadf3ae23d",
      "cbac7d773b1e3b3c6691d7abb7e9df045c8ba19268ded153207f5e804352ec5d",
      "23a196d3802ed3c1b384019a82325840d32f71950c4580b03445e0898e14053c",
      "f4495470f226c8c214be08fdfad4bc4a2a9dbea9136a210df0d4b64929e6fc14",
      "e290dd270b467f34ab1c002d340fa016257ff19e5833fdbbf2cb401c3b2817de",
      "9fc7b5ded3c15042b2a6582dc39be016d24a682d5e61ad1eff9c63309848f706",
      "8cca67a36d17d5e6341cb592fd7bef9926c9e3aa1027ea11a7d8bd260b576e04",
      "409392f560f86831da4373ee5e0074260595d7bc24183b60ed700d4583d3f6f0",
      "2802165de090915546f3398cd849164a19f92adbc361adc99b0f20c8ea071054",
      "ad839168d9f8a4be95ba9ef9a692f07256ae43fe6f9864e290691b0256ce50a9",
      "75fdaa5038c284b86d6e8affe8b2807e467b86600e79af3689fbc06328cbf894",
      "e57cb79487dd57902432b250733813bd96a84efce59f650fac26e6696aefafc3",
      "56f34e8b96557e90c1f24b52d0c89d51086acf1b00f634cf1dde9233b8eaaa3e",
      "1b53ee94aaf34e4b159d48de352c7f0661d0a40edff95a0b1639b4090e974472",
      "05705e2a81757c14bd383ea98dda544eb10e6bc07bae435e2518dbe133525375",
      "d8b2866e8a309db53e529ec32911d82f5ca16cff76216891a9676aa31aaa6c42",
      "f5041c241270eb04c71ec2c95d4c38d803b1237b0f29fd4db3eb397669e88699",
      "9a4ce077c349322f595e0ee79ed0da5fab66752cbfef8f87d0e9d0723c7530dd",
      "657b09f3d0f52b5b8f2f97163a0edf0c04f075408a07bbeb3a4101a891990d62",
      "1e3f7bd5a58fa533344aa8ed3ac122bb9e70d4ef50d004530821948f5fe6315a",
      "80dccf3fd83dfd0d35aa28585922ab89d5313997673eaf905cea9c0b225c7b5f",
      "8a0d0fbf6377d83bb08b514b4b1c43acc95d751714f8925645cb6bc856ca150a",
      "9fa5b487738ad2844cc6348a901918f659a3b89e9c0dfeead30dd94bcf42ef8e",
      "80832c4a1677f5ea2560f668e9354dd36997f03728cfa55e1b38337c0c9ef818",
      "ab37ddb683137e74080d026b590b96ae9bb447722f305a5ac570ec1df9b1743c",
      "3ee735a694c2559b693aa68629361e15d12265ad6a3dedf488b0b00fac9754ba",
      "d6fcd23219b647e4cbd5eb2d0ad01ec8838a4b2901fc325cc3701981ca6c888b",
      "0520ec2f5bf7a755dacb50c6bf233e3515434763db0139ccd9faefbb8207612d",
      "aff3b75f3f581264d7661662b92f5ad37c1d32bd45ff81a4ed8adc9ef30dd989",
      "d0dd650befd3ba63dc25102c627c921b9cbeb0b130686935b5c927cb7ccd5e3b",
      "e1149816b10a8514fb3e2cab2c08bee9f73ce76221701246a589bbb67302d8a9",
      "7da3f441de9054317e72b5dbf979da01e6bceebb8478eae6a22849d90292635c",
      "1230b1fc8a7d9215edc2d4a2decbdd0a6e216c924278c91fc5d10e7d60192d94",
      "5750d716b4808f751febc38806ba170bf6d5199a7816be514e3f932fbe0cb871",
      "6fc59b2f10feba954aa6820b3ca987ee81d5cc1da3c63ce827301c569dfb39ce",
      "c7c3fe1eebdc7b5a939326e8ddb83e8bf2b780b65678cb62f208b040abdd35e2",
      "0c75c1a15cf34a314ee478f4a5ce0b8a6b36528ef7a820696c3e4246c5a15864",
      "216dc12a108569a3c7cdde4aed43a6c330139dda3ccc4a108905db3861899050",
      "a57be6ae6756f28b02f59dadf7e0d7d8807f10fa15ced1ad3585521a1d995a89",
      "816aef875953716cd7a581f732f53dd435dab66d09c361d2d6592de17755d8a8",
      "9a76893226693b6ea97e6a738f9d10fb3d0b43ae0e8b7d8123ea76ce97989c7e",
      "8daedb9a271529dbb7dc3b607fe5eb2d3211770758dd3b0a3593d2d7954e2d5b",
      "16dbc0aa5dd2c774f505100f733786d8a175fcbbb59c43e1fbff3e1eaf31cb4a",
      "8606cb899c6aeaf51b9db0fe4924a9fd5dabc19f8826f2bc1c1d7da14d2c2c99",
      "8479731aeda57bd37eadb51a507e307f3bd95e69dbca94f3bc21726066ad6dfd",
      "58473a9ea82efa3f3b3d8fc83ed8863127b33ae8deae6307201edb6dde61de29",
      "9a9255d53af116de8ba27ce35b4c7e15640657a0fcb888c70d95431dacd8f830",
      "9eb05ffba39fd8596a45493e18d2510bf3ef065c51d6e13abe66aa57e05cfdb7",
      "81dcc3a505eace3f879d8f702776770f9df50e521d1428a85daf04f9ad2150e0",
      "e3e3c4aa3acbbc85332af9d564bc24165e1687f6b1adcbfae77a8f03c72ac28c",
      "6746c80b4eb56aea45e64e7289bba3edbf45ecf8206481ff6302122984cd526a",
      "2b628e52764d7d62c0868b212357cdd12d9149822f4e9845d918a08d1ae990c0",
      "e4bfe80d58c91994613909dc4b1a12496896c004af7b5701483de45d2823d78e",
      "ebb4ba150cef2734345b5d641bbed03a21eafae933c99e009212ef04574a8530",
      "3966ec73b154acc697ac5cf5b24b40bdb0db9e398836d76d4b880e3b2af1aa27",
      "ef7e4831b3a84636518d6e4bfce64a43db2a5dda9cca2b44f39033bdc40d6243",
      "7abf6acf5c8e549ddbb15ae8d8b388c1c197e698737c9785501ed1f94930b7d9",
      "88018ded66813f0ca95def474c630692019967b9e36888dadd94124719b682f6",
      "3930876b9fc7529036b008b1b8bb997522a441635a0c25ec02fb6d9026e55a97",
      "0a4049d57e833b5695fac93dd1fbef3166b44b12ad11248662383ae051e15827",
      "81dcc0678bb6a765e48c3209654fe90089ce44ff5618477e39ab286476df052b",
      "e69b3a36a4461912dc08346b11ddcb9db796f885fd01936e662fe29297b099a4",
      "5ac6503b0d8da6917646e6dcc87edc58e94245324cc204f4dd4af01563acd427",
      "df6dda21359a30bc271780971c1abd56a6ef167e480887888e73a86d3bf605e9",
      "e8e6e47071e7b7df2580f225cfbbedf84ce67746626628d33097e4b7dc571107",
      "53e40ead62051e19cb9ba8133e3e5c1ce00ddcad8acf342a224360b0acc14777",
      "9ccd53fe80be786aa984638462fb28afdf122b34d78f4687ec632bb19de2371a",
      "cbd48052c48d788466a3e8118c56c97fe146e5546faaf93e2bc3c47e45939753",
      "256883b14e2af44dadb28e1b34b2ac0f0f4c91c34ec9169e29036158acaa95b9",
      "4471b91ab42db7c4dd8490ab95a2ee8d04e3ef5c3d6fc71ac74b2b26914d1641",
      "a5eb08038f8f1155ed86e631906fc13095f6bba41de5d4e795758ec8c8df8af1",
      "dc1db64ed8b48a910e060a6b866374c578784e9ac49ab2774092ac71501934ac",
      "285413b2f2ee873d34319ee0bbfbb90f32da434cc87e3db5ed121bb398ed964b",
      "0216e0f81f750f26f1998bc3934e3e124c9945e685a60b25e8fbd9625ab6b599",
      "38c410f5b9d4072050755b31dca89fd5395c6785eeb3d790f320ff941c5a93bf",
      "f18417b39d617ab1c18fdf91ebd0fc6d5516bb34cf39364037bce81fa04cecb1",
      "1fa877de67259d19863a2a34bcc6962a2b25fcbf5cbecd7ede8f1fa36688a796",
      "5bd169e67c82c2c2e98ef7008bdf261f2ddf30b1c00f9e7f275bb3e8a28dc9a2",
      "c80abeebb669ad5deeb5f5ec8ea6b7a05ddf7d31ec4c0a2ee20b0b98caec6746",
      "e76d3fbda5ba374e6bf8e50fadc3bbb9ba5c206ebdec89a3a54cf3dd84a07016",
      "7bba9dc5b5db2071d17752b1044c1eced96aaf2dd46e9b433750e8ea0dcc1870",
      "f29b1b1ab9bab163018ee3da15232cca78ec52dbc34eda5b822ec1d80fc21bd0",
      "9ee3e3e7e900f1e11d308c4b2b3076d272cf70124f9f51e1da60f37846cdd2f4",
      "70ea3b0176927d9096a18508cd123a290325920a9d00a89b5de04273fbc76b85",
      "67de25c02a4aaba23bdc973c8bb0b5796d47cc0659d43dff1f97de174963b68e",
      "b2168e4e0f18b0e64100b517ed95257d73f0620df885c13d2ecf79367b384cee",
      "2e7dec2428853b2c71760745541f7afe9825b5dd77df06511d8441a94bacc927",
      "ca9ffac4c43f0b48461dc5c263bea3f6f00611ceacabf6f895ba2b0101dbb68d",
      "7410d42d8fd1d5e9d2f5815cb93417998828ef3c4230bfbd412df0a4a7a2507a",
      "5010f684516dccd0b6ee0852c2512b4dc0066cf0d56f35302978db8ae32c6a81",
      "acaab585f7b79b719935ceb89523ddc54827f75c56883856154a56cdcd5ee988",
      "666de5d1440fee7331aaf0123a62ef2d8ba57453a0769635ac6cd01e633f7712",
      "a6f98658f6eabaf902d8b3871a4b101d16196e8a4b241e1558fe29966e103e8d",
      "891546a8b29f3047ddcfe5b00e45fd55756373105ea8637dfcff547b6ea9535f",
      "18dfbc1ac5d25b0761137dbd22c17c829d0f0ef1d82344e9c89c286694da24e8",
      "b54b9b67f8fed54bbf5a2666dbdf4b23cff1d1b6f4afc985b2e6d3305a9ff80f",
      "7db442e132ba59bc1289aa98b0d3e806004f8ec12811af1e2e33c69bfde729e1",
      "250f37cdc15e817d2f160d9956c71fe3eb5db74556e4adf9a4ffafba74010396",
      "4ab8a3dd1ddf8ad43dab13a27f66a6544f290597fa96040e0e1db9263aa479f8",
      "ee61727a0766df939ccdc860334044c79a3c9b156200bc3aa32973483d8341ae",
      "3f68c7ec63ac11ebb98f94b339b05c104984fda50103060144e5a2bfccc9da95",
      "056f29816b8af8f56682bc4d7cf094111da7733e726cd13d6b3e8ea03e92a0d5",
      "f5ec43a28acbeff1f3318a5bcac7c66ddb5230b79db2d105bcbe15f3c1148d69",
      "2a6960ad1d8dd547555cfbd5e4600f1eaa1c8eda34de0374ec4a26eaaaa33b4e",
      "dcc1ea7baab93384f76b796866199754742f7b96d6b4c120165c04a6c4f5ce10",
      "13d5df179221379c6a78c07c793ff53487cae6bf9fe882541ab0e735e3eada3b",
      "8c59e4407641a01e8ff91f9980dc236f4ecd6fcf52589a099a961633967714e1",
      "833b1ac6a251fd08fd6d908fea2a4ee1e040bca93fc1a38ec3820e0c10bd82ea",
      "a244f927f3b40b8f6c391570c765418f2f6e708eac9006c51a7feff4af3b2b9e",
      "3d99ed9550cf1196e6c4d20c259620f858c3d703374c128ce7b590310c83046d",
      "2b35c47d7b87761f0ae43ac56ac27b9f25830367b595be8c240e94600c6e3312",
      "5d11ed37d24dc767305cb7e1467d87c065ac4bc8a426de38991ff59aa8735d02",
      "b836478e1ca0640dce6fd910a5096272c8330990cd97864ac2bf14ef6b23914a",
      "9100f946d6ccde3a597f90d39fc1215baddc7413643d85c21c3eee5d2dd32894",
      "da70eedd23e663aa1a74b9766935b479222a72afba5c795158dad41a3bd77e40",
      "f067ed6a0dbd43aa0a9254e69fd66bdd8acb87de936c258cfb02285f2c11fa79",
      "715c99c7d57580cf9753b4c1d795e45a83fbb228c0d36fbe20faf39bdd6d4e85",
      "e457d6ad1e67cb9bbd17cbd698fa6d7dae0c9b7ad6cbd6539634e32a719c8492",
      "ece3ea8103e02483c64a70a4bdcee8ceb6278f2533f3f48dbeedfba94531d4ae",
      "388aa5d3667a97c68d3d56f8f3ee8d3d36091f17fe5d1b0d5d84c93b2ffe40bd",
      "8b6b31b9ad7c3d5cd84bf98947b9cdb59df8a25ff738101013be4fd65e1dd1a3",
      "066291f6bbd25f3c853db7d8b95c9a1cfb9bf1c1c99fb95a9b7869d90f1c2903",
      "a707efbccdceed42967a66f5539b93ed7560d467304016c4780d7755a565d4c4",
      "38c53dfb70be7e792b07a6a35b8a6a0aba02c5c5f38baf5c823fdfd9e42d657e",
      "f2911386501d9ab9d720cf8ad10503d5634bf4b7d12b56dfb74fecc6e4093f68",
      "c6f2bdd52b81e6e4f6595abd4d7fb31f651169d00ff326926b34947b28a83959",
      "293d94b18c98bb3223366b8ce74c28fbdf28e1f84a3350b0eb2d1804a577579b",
      "2c2fa5c0b51533165bc375c22e2781768270a383985d13bd6b67b6fd67f889eb",
      "caa09b82b72562e43f4b2275c091918e624d911661cc811bb5faec51f6088ef7",
      "24761e45e674395379fb17729c78cb939e6f74c5dffb9c961f495982c3ed1fe3",
      "55b70a82131ec94888d7ab54a7c515255c3938bb10bc784dc9b67f076e341a73",
      "6ab9057b977ebc3ca4d4ce74506c25cccdc566497c450b5415a39486f8657a03",
      "24066deee0ecee15a45f0a326d0f8dbc79761ebb93cf8c0377af440978fcf994",
      "20000d3f66ba76860d5a950688b9aa0d76cfea59b005d859914b1a46653a939b",
      "b92daa79603e3bdbc3bfe0f419e409b2ea10dc435beefe2959da16895d5dca1c",
      "e947948705b206d572b0e8f62f66a6551cbd6bc305d26ce7539a12f9aadf7571",
      "3d67c1b3f9b23910e3d35e6b0f2ccf44a0b540a45c18ba3c36264dd48e96af6a",
      "c7558babda04bccb764d0bbf3358425141902d22391d9f8c59159fec9e49b151",
      "0b732bb035675a50ff58f2c242e4710aece64670079c13044c79c9b7491f7000",
      "d120b5ef6d57ebf06eaf96bc933c967b16cbe6e2bf00741c30aa1c54ba64801f",
      "58d212ad6f58aef0f80116b441e57f6195bfef26b61463edec1183cdb04fe76d",
      "b8836f51d1e29bdfdba325565360268b8fad627473edecef7eaefee837c74003",
      "c547a3c124ae5685ffa7b8edaf96ec86f8b2d0d50cee8be3b1f0c76763069d9c",
      "5d168b769a2f67853d6295f7568be40bb7a16b8d65ba87635d1978d2ab11ba2a",
      "a2f675dc7302638cb60201064ca55077714d71fe096a315f2fe7401277caa5af",
      "c8aab5cd0160ae78cd2e8ac5fb0e093cdb5c4b6052a0a97bb04216826fa7a437",
      "ff68ca4035bfeb43fbf145fddd5e43f1cea54f11f7bee13058f027329a4a5fa4",
      "1d4e5487ae3c740f2ba6e541ac91bc2bfcd2999c518d807b426748803a350fd4",
      "6d244e1a06ce4ef578dd0f63aff0936706735119ca9c8d22d86c801414ab9741",
      "decf7329dbcc827b8fc524c9431e8998029ece12ce93b7b2f3e769a941fb8cea",
      "2fafcc0f2e63cbd07755be7b75ecea0adff9aa5ede2a52fdab4dfd0374cd483f",
      "aa85010dd46a546b535ef4cf5f07d65161e89828f3a77db7b9b56f0df59aae45",
      "07e8e1ee732cb0d356c9c0d1069c89d17adf6a9a334f745ec7867332548ca8e9",
      "0e01e81cada8162bfd5f8a8c818a6c69fedf02ceb5208523cbe5313b89ca1053",
      "6bb6c6472655084399852e00249f8cb247896d392b02d73b7f0dd818e1e29b07",
      "42d4636e2060f08f41c882e76b396b112ef627cc24c43dd5f83a1d1a7ead711a",
      "4858c9a188b0234fb9a8d47d0b4133650a030bd0611b87c3892e94951f8df852",
      "3fab3e36988d445a51c8783e531be3a02be40cd04796cfb61d40347442d3f794",
      "ebabc49636bd433d2ec8f0e518732ef8fa21d4d071cc3bc46cd79fa38a28b810",
      "a1d0343523b893fca84f47feb4a64d350a17d8eef5497ece697d02d79178b591",
      "262ebfd9130b7d28760d08ef8bfd3b86cdd3b2113d2caef7ea951a303dfa3846",
      "f76158edd50a154fa78203ed2362932fcb8253aae378903eded1e03f7021a257",
      "26178e950ac722f67ae56e571b284c0207684a6334a17748a94d260bc5f55274",
      "c378d1e493b40ef11fe6a15d9c2737a37809634c5abad5b33d7e393b4ae05d03",
      "984bd8379101be8fd80612d8ea2959a7865ec9718523550107ae3938df32011b",
      "c6f25a812a144858ac5ced37a93a9f4759ba0b1c0fdc431dce35f9ec1f1f4a99",
      "924c75c94424ff75e74b8b4e94358958b027b171df5e57899ad0d4dac37353b6",
      "0af35892a63f45931f6846ed190361cd073089e077165714b50b81a2e3dd9ba1",
      "cc80cefb26c3b2b0daef233e606d5ffc80fa17427d18e30489673e06ef4b87f7",
      "c2f8c8117447f3978b0818dcf6f70116ac56fd184dd1278494e103fc6d74a887",
      "bdecf6bfc1ba0df6e862c831992207796acc797968358828c06e7a51e090098f",
      "24d1a26e3dab02fe4572d2aa7dbd3ec30f0693db26f273d0ab2cb0c13b5e6451",
      "ec56f58b09299a300b140565d7d3e68782b6e2fbeb4b7ea97ac057989061dd3f",
      "11a437c1aba3c119ddfab31b3e8c841deeeb913ef57f7e48f2c9cf5a28fa42bc",
      "53c7e6114b850a2cb496c9b3c69a623eaea2cb1d33dd817e4765edaa6823c228",
      "154c3e96fee5db14f8773e18af14857913509da999b46cdd3d4c169760c83ad2",
      "40b9916f093e027a8786641818920620472fbcf68f701d1b680632e6996bded3",
      "24c4cbba07119831a726b05305d96da02ff8b148f0da440fe233bcaa32c72f6f",
      "5d201510250020b783689688abbf8ecf2594a96a08f2bfec6ce0574465dded71",
      "043b97e336ee6fdbbe2b50f22af83275a4084805d2d5645962454b6c9b8053a0",
      "564835cbaea774948568be36cf52fcdd83934eb0a27512dbe3e2db47b9e6635a",
      "f21c33f47bde40a2a101c9cde8027aaf61a3137de2422b30035a04c270894183",
      "9db0ef74e66cbb842eb0e07343a03c5c567e372b3f23b943c788a4f250f67891",
      "ab8d08655ff1d3fe8758d562235fd23e7cf9dcaad658872a49e5d3183b6ccebd",
      "6f27f77e7bcf46a1e963ade0309733543031dccdd47caac174d7d27ce8077e8b",
      "e3cd54da7e444caa6207569525a670ebae1278de4e3fe2684b3e33f5ef90cc1b",
      "b2c3e33a51d22c4c08fc0989c873c9cc4150579b1e6163fa694ad51d53d712dc",
      "be7fda983e13189b4c77e0a80920b6e0e0ea80c3b84dbe7e7117d253f48112f4",
      "b6008c28fae08aa427e5bd3aad36f10021f16c77cfeabed07f97cc7dc1f1284a",
      "6e4e6760c538f2e97b3adbfbbcde57f8966b7ea8fcb5bf7efec913fd2a2b0c55",
      "4ae51fd1834aa5bd9a6f7ec39fc663338dc5d2e20761566d90cc68b1cb875ed8",
      "b673aad75ab1fdb5401abfa1bf89f3add2ebc468df3624a478f4fe859d8d55e2",
      "13c9471a9855913539836660398da0f3f99ada08479c69d1b7fcaa3461dd7e59",
      "2c11f4a7f99a1d23a58bb636350fe849f29cbac1b2a1112d9f1ed5bc5b313ccd",
      "c7d3c0706b11ae741c05a1ef150dd65b5494d6d54c9a86e2617854e6aeeebbd9",
      "194e10c93893afa064c3ac04c0dd808d791c3d4b7556e89d8d9cb225c4b33339",
      "6fc4988b8f78546b1688991845908f134b6a482e6994b3d48317bf08db292185",
      "5665beb8b0955525813b5981cd142ed4d03fba38a6f3e5ad268e0cc270d1cd11",
      "b883d68f5fe51936431ba4256738053b1d0426d4cb64b16e83badc5e9fbe3b81",
      "53e7b27ea59c2f6dbb50769e43554df35af89f4822d0466b007dd6f6deafff02",
      "1f1a0229d4640f01901588d9dec22d13fc3eb34a61b32938efbf5334b2800afa",
      "c2b405afa0fa6668852aee4d88040853fab800e72b57581418e5506f214c7d1f",
      "c08aa1c286d709fdc7473744977188c895ba011014247e4efa8d07e78fec695c",
      "f03f5789d3336b80d002d59fdf918bdb775b00956ed5528e86aa994acb38fe2d"
    ];

    var goldenKeyed = [
      "48a8997da407876b3d79c0d92325ad3b89cbb754d86ab71aee047ad345fd2c49",
      "40d15fee7c328830166ac3f918650f807e7e01e177258cdc0a39b11f598066f1",
      "6bb71300644cd3991b26ccd4d274acd1adeab8b1d7914546c1198bbe9fc9d803",
      "1d220dbe2ee134661fdf6d9e74b41704710556f2f6e5a091b227697445dbea6b",
      "f6c3fbadb4cc687a0064a5be6e791bec63b868ad62fba61b3757ef9ca52e05b2",
      "49c1f21188dfd769aea0e911dd6b41f14dab109d2b85977aa3088b5c707e8598",
      "fdd8993dcd43f696d44f3cea0ff35345234ec8ee083eb3cada017c7f78c17143",
      "e6c8125637438d0905b749f46560ac89fd471cf8692e28fab982f73f019b83a9",
      "19fc8ca6979d60e6edd3b4541e2f967ced740df6ec1eaebbfe813832e96b2974",
      "a6ad777ce881b52bb5a4421ab6cdd2dfba13e963652d4d6d122aee46548c14a7",
      "f5c4b2ba1a00781b13aba0425242c69cb1552f3f71a9a3bb22b4a6b4277b46dd",
      "e33c4c9bd0cc7e45c80e65c77fa5997fec7002738541509e68a9423891e822a3",
      "fba16169b2c3ee105be6e1e650e5cbf40746b6753d036ab55179014ad7ef6651",
      "f5c4bec6d62fc608bf41cc115f16d61c7efd3ff6c65692bbe0afffb1fede7475",
      "a4862e76db847f05ba17ede5da4e7f91b5925cf1ad4ba12732c3995742a5cd6e",
      "65f4b860cd15b38ef814a1a804314a55be953caa65fd758ad989ff34a41c1eea",
      "19ba234f0a4f38637d1839f9d9f76ad91c8522307143c97d5f93f69274cec9a7",
      "1a67186ca4a5cb8e65fca0e2ecbc5ddc14ae381bb8bffeb9e0a103449e3ef03c",
      "afbea317b5a2e89c0bd90ccf5d7fd0ed57fe585e4be3271b0a6bf0f5786b0f26",
      "f1b01558ce541262f5ec34299d6fb4090009e3434be2f49105cf46af4d2d4124",
      "13a0a0c86335635eaa74ca2d5d488c797bbb4f47dc07105015ed6a1f3309efce",
      "1580afeebebb346f94d59fe62da0b79237ead7b1491f5667a90e45edf6ca8b03",
      "20be1a875b38c573dd7faaa0de489d655c11efb6a552698e07a2d331b5f655c3",
      "be1fe3c4c04018c54c4a0f6b9a2ed3c53abe3a9f76b4d26de56fc9ae95059a99",
      "e3e3ace537eb3edd8463d9ad3582e13cf86533ffde43d668dd2e93bbdbd7195a",
      "110c50c0bf2c6e7aeb7e435d92d132ab6655168e78a2decdec3330777684d9c1",
      "e9ba8f505c9c80c08666a701f3367e6cc665f34b22e73c3c0417eb1c2206082f",
      "26cd66fca02379c76df12317052bcafd6cd8c3a7b890d805f36c49989782433a",
      "213f3596d6e3a5d0e9932cd2159146015e2abc949f4729ee2632fe1edb78d337",
      "1015d70108e03be1c702fe97253607d14aee591f2413ea6787427b6459ff219a",
      "3ca989de10cfe609909472c8d35610805b2f977734cf652cc64b3bfc882d5d89",
      "b6156f72d380ee9ea6acd190464f2307a5c179ef01fd71f99f2d0f7a57360aea",
      "c03bc642b20959cbe133a0303e0c1abff3e31ec8e1a328ec8565c36decff5265",
      "2c3e08176f760c6264c3a2cd66fec6c3d78de43fc192457b2a4a660a1e0eb22b",
      "f738c02f3c1b190c512b1a32deabf353728e0e9ab034490e3c3409946a97aeec",
      "8b1880df301cc963418811088964839287ff7fe31c49ea6ebd9e48bdeee497c5",
      "1e75cb21c60989020375f1a7a242839f0b0b68973a4c2a05cf7555ed5aaec4c1",
      "62bf8a9c32a5bccf290b6c474d75b2a2a4093f1a9e27139433a8f2b3bce7b8d7",
      "166c8350d3173b5e702b783dfd33c66ee0432742e9b92b997fd23c60dc6756ca",
      "044a14d822a90cacf2f5a101428adc8f4109386ccb158bf905c8618b8ee24ec3",
      "387d397ea43a994be84d2d544afbe481a2000f55252696bba2c50c8ebd101347",
      "56f8ccf1f86409b46ce36166ae9165138441577589db08cbc5f66ca29743b9fd",
      "9706c092b04d91f53dff91fa37b7493d28b576b5d710469df79401662236fc03",
      "877968686c068ce2f7e2adcff68bf8748edf3cf862cfb4d3947a3106958054e3",
      "8817e5719879acf7024787eccdb271035566cfa333e049407c0178ccc57a5b9f",
      "8938249e4b50cadaccdf5b18621326cbb15253e33a20f5636e995d72478de472",
      "f164abba4963a44d107257e3232d90aca5e66a1408248c51741e991db5227756",
      "d05563e2b1cba0c4a2a1e8bde3a1a0d9f5b40c85a070d6f5fb21066ead5d0601",
      "03fbb16384f0a3866f4c3117877666efbf124597564b293d4aab0d269fabddfa",
      "5fa8486ac0e52964d1881bbe338eb54be2f719549224892057b4da04ba8b3475",
      "cdfabcee46911111236a31708b2539d71fc211d9b09c0d8530a11e1dbf6eed01",
      "4f82de03b9504793b82a07a0bdcdff314d759e7b62d26b784946b0d36f916f52",
      "259ec7f173bcc76a0994c967b4f5f024c56057fb79c965c4fae41875f06a0e4c",
      "193cc8e7c3e08bb30f5437aa27ade1f142369b246a675b2383e6da9b49a9809e",
      "5c10896f0e2856b2a2eee0fe4a2c1633565d18f0e93e1fab26c373e8f829654d",
      "f16012d93f28851a1eb989f5d0b43f3f39ca73c9a62d5181bff237536bd348c3",
      "2966b3cfae1e44ea996dc5d686cf25fa053fb6f67201b9e46eade85d0ad6b806",
      "ddb8782485e900bc60bcf4c33a6fd585680cc683d516efa03eb9985fad8715fb",
      "4c4d6e71aea05786413148fc7a786b0ecaf582cff1209f5a809fba8504ce662c",
      "fb4c5e86d7b2229b99b8ba6d94c247ef964aa3a2bae8edc77569f28dbbff2d4e",
      "e94f526de9019633ecd54ac6120f23958d7718f1e7717bf329211a4faeed4e6d",
      "cbd6660a10db3f23f7a03d4b9d4044c7932b2801ac89d60bc9eb92d65a46c2a0",
      "8818bbd3db4dc123b25cbba5f54c2bc4b3fcf9bf7d7a7709f4ae588b267c4ece",
      "c65382513f07460da39833cb666c5ed82e61b9e998f4b0c4287cee56c3cc9bcd",
      "8975b0577fd35566d750b362b0897a26c399136df07bababbde6203ff2954ed4",
      "21fe0ceb0052be7fb0f004187cacd7de67fa6eb0938d927677f2398c132317a8",
      "2ef73f3c26f12d93889f3c78b6a66c1d52b649dc9e856e2c172ea7c58ac2b5e3",
      "388a3cd56d73867abb5f8401492b6e2681eb69851e767fd84210a56076fb3dd3",
      "af533e022fc9439e4e3cb838ecd18692232adf6fe9839526d3c3dd1b71910b1a",
      "751c09d41a9343882a81cd13ee40818d12eb44c6c7f40df16e4aea8fab91972a",
      "5b73ddb68d9d2b0aa265a07988d6b88ae9aac582af83032f8a9b21a2e1b7bf18",
      "3da29126c7c5d7f43e64242a79feaa4ef3459cdeccc898ed59a97f6ec93b9dab",
      "566dc920293da5cb4fe0aa8abda8bbf56f552313bff19046641e3615c1e3ed3f",
      "4115bea02f73f97f629e5c5590720c01e7e449ae2a6697d4d2783321303692f9",
      "4ce08f4762468a7670012164878d68340c52a35e66c1884d5c864889abc96677",
      "81ea0b7804124e0c22ea5fc71104a2afcb52a1fa816f3ecb7dcb5d9dea1786d0",
      "fe362733b05f6bedaf9379d7f7936ede209b1f8323c3922549d9e73681b5db7b",
      "eff37d30dfd20359be4e73fdf40d27734b3df90a97a55ed745297294ca85d09f",
      "172ffc67153d12e0ca76a8b6cd5d4731885b39ce0cac93a8972a18006c8b8baf",
      "c47957f1cc88e83ef9445839709a480a036bed5f88ac0fcc8e1e703ffaac132c",
      "30f3548370cfdceda5c37b569b6175e799eef1a62aaa943245ae7669c227a7b5",
      "c95dcb3cf1f27d0eef2f25d2413870904a877c4a56c2de1e83e2bc2ae2e46821",
      "d5d0b5d705434cd46b185749f66bfb5836dcdf6ee549a2b7a4aee7f58007caaf",
      "bbc124a712f15d07c300e05b668389a439c91777f721f8320c1c9078066d2c7e",
      "a451b48c35a6c7854cfaae60262e76990816382ac0667e5a5c9e1b46c4342ddf",
      "b0d150fb55e778d01147f0b5d89d99ecb20ff07e5e6760d6b645eb5b654c622b",
      "34f737c0ab219951eee89a9f8dac299c9d4c38f33fa494c5c6eefc92b6db08bc",
      "1a62cc3a00800dcbd99891080c1e098458193a8cc9f970ea99fbeff00318c289",
      "cfce55ebafc840d7ae48281c7fd57ec8b482d4b704437495495ac414cf4a374b",
      "6746facf71146d999dabd05d093ae586648d1ee28e72617b99d0f0086e1e45bf",
      "571ced283b3f23b4e750bf12a2caf1781847bd890e43603cdc5976102b7bb11b",
      "cfcb765b048e35022c5d089d26e85a36b005a2b80493d03a144e09f409b6afd1",
      "4050c7a27705bb27f42089b299f3cbe5054ead68727e8ef9318ce6f25cd6f31d",
      "184070bd5d265fbdc142cd1c5cd0d7e414e70369a266d627c8fba84fa5e84c34",
      "9edda9a4443902a9588c0d0ccc62b930218479a6841e6fe7d43003f04b1fd643",
      "e412feef7908324a6da1841629f35d3d358642019310ec57c614836b63d30763",
      "1a2b8edff3f9acc1554fcbae3cf1d6298c6462e22e5eb0259684f835012bd13f",
      "288c4ad9b9409762ea07c24a41f04f69a7d74bee2d95435374bde946d7241c7b",
      "805691bb286748cfb591d3aebe7e6f4e4dc6e2808c65143cc004e4eb6fd09d43",
      "d4ac8d3a0afc6cfa7b460ae3001baeb36dadb37da07d2e8ac91822df348aed3d",
      "c376617014d20158bced3d3ba552b6eccf84e62aa3eb650e90029c84d13eea69",
      "c41f09f43cecae7293d6007ca0a357087d5ae59be500c1cd5b289ee810c7b082",
      "03d1ced1fba5c39155c44b7765cb760c78708dcfc80b0bd8ade3a56da8830b29",
      "09bde6f152218dc92c41d7f45387e63e5869d807ec70b821405dbd884b7fcf4b",
      "71c9036e18179b90b37d39e9f05eb89cc5fc341fd7c477d0d7493285faca08a4",
      "5916833ebb05cd919ca7fe83b692d3205bef72392b2cf6bb0a6d43f994f95f11",
      "f63aab3ec641b3b024964c2b437c04f6043c4c7e0279239995401958f86bbe54",
      "f172b180bfb09740493120b6326cbdc561e477def9bbcfd28cc8c1c5e3379a31",
      "cb9b89cc18381dd9141ade588654d4e6a231d5bf49d4d59ac27d869cbe100cf3",
      "7bd8815046fdd810a923e1984aaebdcdf84d87c8992d68b5eeb460f93eb3c8d7",
      "607be66862fd08ee5b19facac09dfdbcd40c312101d66e6ebd2b841f1b9a9325",
      "9fe03bbe69ab1834f5219b0da88a08b30a66c5913f0151963c360560db0387b3",
      "90a83585717b75f0e9b725e055eeeeb9e7a028ea7e6cbc07b20917ec0363e38c",
      "336ea0530f4a7469126e0218587ebbde3358a0b31c29d200f7dc7eb15c6aadd8",
      "a79e76dc0abca4396f0747cd7b748df913007626b1d659da0c1f78b9303d01a3",
      "44e78a773756e0951519504d7038d28d0213a37e0ce375371757bc996311e3b8",
      "77ac012a3f754dcfeab5eb996be9cd2d1f96111b6e49f3994df181f28569d825",
      "ce5a10db6fccdaf140aaa4ded6250a9c06e9222bc9f9f3658a4aff935f2b9f3a",
      "ecc203a7fe2be4abd55bb53e6e673572e0078da8cd375ef430cc97f9f80083af",
      "14a5186de9d7a18b0412b8563e51cc5433840b4a129a8ff963b33a3c4afe8ebb",
      "13f8ef95cb86e6a638931c8e107673eb76ba10d7c2cd70b9d9920bbeed929409",
      "0b338f4ee12f2dfcb78713377941e0b0632152581d1332516e4a2cab1942cca4",
      "eaab0ec37b3b8ab796e9f57238de14a264a076f3887d86e29bb5906db5a00e02",
      "23cb68b8c0e6dc26dc27766ddc0a13a99438fd55617aa4095d8f969720c872df",
      "091d8ee30d6f2968d46b687dd65292665742de0bb83dcc0004c72ce10007a549",
      "7f507abc6d19ba00c065a876ec5657868882d18a221bc46c7a6912541f5bc7ba",
      "a0607c24e14e8c223db0d70b4d30ee88014d603f437e9e02aa7dafa3cdfbad94",
      "ddbfea75cc467882eb3483ce5e2e756a4f4701b76b445519e89f22d60fa86e06",
      "0c311f38c35a4fb90d651c289d486856cd1413df9b0677f53ece2cd9e477c60a",
      "46a73a8dd3e70f59d3942c01df599def783c9da82fd83222cd662b53dce7dbdf",
      "ad038ff9b14de84a801e4e621ce5df029dd93520d0c2fa38bff176a8b1d1698c",
      "ab70c5dfbd1ea817fed0cd067293abf319e5d7901c2141d5d99b23f03a38e748",
      "1fffda67932b73c8ecaf009a3491a026953babfe1f663b0697c3c4ae8b2e7dcb",
      "b0d2cc19472dd57f2b17efc03c8d58c2283dbb19da572f7755855aa9794317a0",
      "a0d19a6ee33979c325510e276622df41f71583d07501b87071129a0ad94732a5",
      "724642a7032d1062b89e52bea34b75df7d8fe772d9fe3c93ddf3c4545ab5a99b",
      "ade5eaa7e61f672d587ea03dae7d7b55229c01d06bc0a5701436cbd18366a626",
      "013b31ebd228fcdda51fabb03bb02d60ac20ca215aafa83bdd855e3755a35f0b",
      "332ed40bb10dde3c954a75d7b8999d4b26a1c063c1dc6e32c1d91bab7bbb7d16",
      "c7a197b3a05b566bcc9facd20e441d6f6c2860ac9651cd51d6b9d2cdeeea0390",
      "bd9cf64ea8953c037108e6f654914f3958b68e29c16700dc184d94a21708ff60",
      "8835b0ac021151df716474ce27ce4d3c15f0b2dab48003cf3f3efd0945106b9a",
      "3bfefa3301aa55c080190cffda8eae51d9af488b4c1f24c3d9a75242fd8ea01d",
      "08284d14993cd47d53ebaecf0df0478cc182c89c00e1859c84851686ddf2c1b7",
      "1ed7ef9f04c2ac8db6a864db131087f27065098e69c3fe78718d9b947f4a39d0",
      "c161f2dcd57e9c1439b31a9dd43d8f3d7dd8f0eb7cfac6fb25a0f28e306f0661",
      "c01969ad34c52caf3dc4d80d19735c29731ac6e7a92085ab9250c48dea48a3fc",
      "1720b3655619d2a52b3521ae0e49e345cb3389ebd6208acaf9f13fdacca8be49",
      "756288361c83e24c617cf95c905b22d017cdc86f0bf1d658f4756c7379873b7f",
      "e7d0eda3452693b752abcda1b55e276f82698f5f1605403eff830bea0071a394",
      "2c82ecaa6b84803e044af63118afe544687cb6e6c7df49ed762dfd7c8693a1bc",
      "6136cbf4b441056fa1e2722498125d6ded45e17b52143959c7f4d4e395218ac2",
      "721d3245aafef27f6a624f47954b6c255079526ffa25e9ff77e5dcff473b1597",
      "9dd2fbd8cef16c353c0ac21191d509eb28dd9e3e0d8cea5d26ca839393851c3a",
      "b2394ceacdebf21bf9df2ced98e58f1c3a4bbbff660dd900f62202d6785cc46e",
      "57089f222749ad7871765f062b114f43ba20ec56422a8b1e3f87192c0ea718c6",
      "e49a9459961cd33cdf4aae1b1078a5dea7c040e0fea340c93a724872fc4af806",
      "ede67f720effd2ca9c88994152d0201dee6b0a2d2c077aca6dae29f73f8b6309",
      "e0f434bf22e3088039c21f719ffc67f0f2cb5e98a7a0194c76e96bf4e8e17e61",
      "277c04e2853484a4eba910ad336d01b477b67cc200c59f3c8d77eef8494f29cd",
      "156d5747d0c99c7f27097d7b7e002b2e185cb72d8dd7eb424a0321528161219f",
      "20ddd1ed9b1ca803946d64a83ae4659da67fba7a1a3eddb1e103c0f5e03e3a2c",
      "f0af604d3dabbf9a0f2a7d3dda6bd38bba72c6d09be494fcef713ff10189b6e6",
      "9802bb87def4cc10c4a5fd49aa58dfe2f3fddb46b4708814ead81d23ba95139b",
      "4f8ce1e51d2fe7f24043a904d898ebfc91975418753413aa099b795ecb35cedb",
      "bddc6514d7ee6ace0a4ac1d0e068112288cbcf560454642705630177cba608bd",
      "d635994f6291517b0281ffdd496afa862712e5b3c4e52e4cd5fdae8c0e72fb08",
      "878d9ca600cf87e769cc305c1b35255186615a73a0da613b5f1c98dbf81283ea",
      "a64ebe5dc185de9fdde7607b6998702eb23456184957307d2fa72e87a47702d6",
      "ce50eab7b5eb52bdc9ad8e5a480ab780ca9320e44360b1fe37e03f2f7ad7de01",
      "eeddb7c0db6e30abe66d79e327511e61fcebbc29f159b40a86b046ecf0513823",
      "787fc93440c1ec96b5ad01c16cf77916a1405f9426356ec921d8dff3ea63b7e0",
      "7f0d5eab47eefda696c0bf0fbf86ab216fce461e9303aba6ac374120e890e8df",
      "b68004b42f14ad029f4c2e03b1d5eb76d57160e26476d21131bef20ada7d27f4",
      "b0c4eb18ae250b51a41382ead92d0dc7455f9379fc9884428e4770608db0faec",
      "f92b7a870c059f4d46464c824ec96355140bdce681322cc3a992ff103e3fea52",
      "5364312614813398cc525d4c4e146edeb371265fba19133a2c3d2159298a1742",
      "f6620e68d37fb2af5000fc28e23b832297ecd8bce99e8be4d04e85309e3d3374",
      "5316a27969d7fe04ff27b283961bffc3bf5dfb32fb6a89d101c6c3b1937c2871",
      "81d1664fdf3cb33c24eebac0bd64244b77c4abea90bbe8b5ee0b2aafcf2d6a53",
      "345782f295b0880352e924a0467b5fbc3e8f3bfbc3c7e48b67091fb5e80a9442",
      "794111ea6cd65e311f74ee41d476cb632ce1e4b051dc1d9e9d061a19e1d0bb49",
      "2a85daf6138816b99bf8d08ba2114b7ab07975a78420c1a3b06a777c22dd8bcb",
      "89b0d5f289ec16401a069a960d0b093e625da3cf41ee29b59b930c5820145455",
      "d0fdcb543943fc27d20864f52181471b942cc77ca675bcb30df31d358ef7b1eb",
      "b17ea8d77063c709d4dc6b879413c343e3790e9e62ca85b7900b086f6b75c672",
      "e71a3e2c274db842d92114f217e2c0eac8b45093fdfd9df4ca7162394862d501",
      "c0476759ab7aa333234f6b44f5fd858390ec23694c622cb986e769c78edd733e",
      "9ab8eabb1416434d85391341d56993c55458167d4418b19a0f2ad8b79a83a75b",
      "7992d0bbb15e23826f443e00505d68d3ed7372995a5c3e498654102fbcd0964e",
      "c021b30085151435df33b007ccecc69df1269f39ba25092bed59d932ac0fdc28",
      "91a25ec0ec0d9a567f89c4bfe1a65a0e432d07064b4190e27dfb81901fd3139b",
      "5950d39a23e1545f301270aa1a12f2e6c453776e4d6355de425cc153f9818867",
      "d79f14720c610af179a3765d4b7c0968f977962dbf655b521272b6f1e194488e",
      "e9531bfc8b02995aeaa75ba27031fadbcbf4a0dab8961d9296cd7e84d25d6006",
      "34e9c26a01d7f16181b454a9d1623c233cb99d31c694656e9413aca3e918692f",
      "d9d7422f437bd439ddd4d883dae2a08350173414be78155133fff1964c3d7972",
      "4aee0c7aaf075414ff1793ead7eaca601775c615dbd60b640b0a9f0ce505d435",
      "6bfdd15459c83b99f096bfb49ee87b063d69c1974c6928acfcfb4099f8c4ef67",
      "9fd1c408fd75c336193a2a14d94f6af5adf050b80387b4b010fb29f4cc72707c",
      "13c88480a5d00d6c8c7ad2110d76a82d9b70f4fa6696d4e5dd42a066dcaf9920",
      "820e725ee25fe8fd3a8d5abe4c46c3ba889de6fa9191aa22ba67d5705421542b",
      "32d93a0eb02f42fbbcaf2bad0085b282e46046a4df7ad10657c9d6476375b93e",
      "adc5187905b1669cd8ec9c721e1953786b9d89a9bae30780f1e1eab24a00523c",
      "e90756ff7f9ad810b239a10ced2cf9b2284354c1f8c7e0accc2461dc796d6e89",
      "1251f76e56978481875359801db589a0b22f86d8d634dc04506f322ed78f17e8",
      "3afa899fd980e73ecb7f4d8b8f291dc9af796bc65d27f974c6f193c9191a09fd",
      "aa305be26e5deddc3c1010cbc213f95f051c785c5b431e6a7cd048f161787528",
      "8ea1884ff32e9d10f039b407d0d44e7e670abd884aeee0fb757ae94eaa97373d",
      "d482b2155d4dec6b4736a1f1617b53aaa37310277d3fef0c37ad41768fc235b4",
      "4d413971387e7a8898a8dc2a27500778539ea214a2dfe9b3d7e8ebdce5cf3db3",
      "696e5d46e6c57e8796e4735d08916e0b7929b3cf298c296d22e9d3019653371c",
      "1f5647c1d3b088228885865c8940908bf40d1a8272821973b160008e7a3ce2eb",
      "b6e76c330f021a5bda65875010b0edf09126c0f510ea849048192003aef4c61c",
      "3cd952a0beada41abb424ce47f94b42be64e1ffb0fd0782276807946d0d0bc55",
      "98d92677439b41b7bb513312afb92bcc8ee968b2e3b238cecb9b0f34c9bb63d0",
      "ecbca2cf08ae57d517ad16158a32bfa7dc0382eaeda128e91886734c24a0b29d",
      "942cc7c0b52e2b16a4b89fa4fc7e0bf609e29a08c1a8543452b77c7bfd11bb28",
      "8a065d8b61a0dffb170d5627735a76b0e9506037808cba16c345007c9f79cf8f",
      "1b9fa19714659c78ff413871849215361029ac802b1cbcd54e408bd87287f81f",
      "8dab071bcd6c7292a9ef727b4ae0d86713301da8618d9a48adce55f303a869a1",
      "8253e3e7c7b684b9cb2beb014ce330ff3d99d17abbdbabe4f4d674ded53ffc6b",
      "f195f321e9e3d6bd7d074504dd2ab0e6241f92e784b1aa271ff648b1cab6d7f6",
      "27e4cc72090f241266476a7c09495f2db153d5bcbd761903ef79275ec56b2ed8",
      "899c2405788e25b99a1846355e646d77cf400083415f7dc5afe69d6e17c00023",
      "a59b78c4905744076bfee894de707d4f120b5c6893ea0400297d0bb834727632",
      "59dc78b105649707a2bb4419c48f005400d3973de3736610230435b10424b24f",
      "c0149d1d7e7a6353a6d906efe728f2f329fe14a4149a3ea77609bc42b975ddfa",
      "a32f241474a6c16932e9243be0cf09bcdc7e0ca0e7a6a1b9b1a0f01e41502377",
      "b239b2e4f81841361c1339f68e2c359f929af9ad9f34e01aab4631ad6d5500b0",
      "85fb419c7002a3e0b4b6ea093b4c1ac6936645b65dac5ac15a8528b7b94c1754",
      "9619720625f190b93a3fad186ab314189633c0d3a01e6f9bc8c4a8f82f383dbf",
      "7d620d90fe69fa469a6538388970a1aa09bb48a2d59b347b97e8ce71f48c7f46",
      "294383568596fb37c75bbacd979c5ff6f20a556bf8879cc72924855df9b8240e",
      "16b18ab314359c2b833c1c6986d48c55a9fc97cde9a3c1f10a3177140f73f738",
      "8cbbdd14bc33f04cf45813e4a153a273d36adad5ce71f499eeb87fb8ac63b729",
      "69c9a498db174ecaefcc5a3ac9fdedf0f813a5bec727f1e775babdec7718816e",
      "b462c3be40448f1d4f80626254e535b08bc9cdcff599a768578d4b2881a8e3f0",
      "553e9d9c5f360ac0b74a7d44e5a391dad4ced03e0c24183b7e8ecabdf1715a64",
      "7a7c55a56fa9ae51e655e01975d8a6ff4ae9e4b486fcbe4eac044588f245ebea",
      "2afdf3c82abc4867f5de111286c2b3be7d6e48657ba923cfbf101a6dfcf9db9a",
      "41037d2edcdce0c49b7fb4a6aa0999ca66976c7483afe631d4eda283144f6dfc",
      "c4466f8497ca2eeb4583a0b08e9d9ac74395709fda109d24f2e4462196779c5d",
      "75f609338aa67d969a2ae2a2362b2da9d77c695dfd1df7224a6901db932c3364",
      "68606ceb989d5488fc7cf649f3d7c272ef055da1a93faecd55fe06f6967098ca",
      "44346bdeb7e052f6255048f0d9b42c425bab9c3dd24168212c3ecf1ebf34e6ae",
      "8e9cf6e1f366471f2ac7d2ee9b5e6266fda71f8f2e4109f2237ed5f8813fc718",
      "84bbeb8406d250951f8c1b3e86a7c010082921833dfd9555a2f909b1086eb4b8",
      "ee666f3eef0f7e2a9c222958c97eaf35f51ced393d714485ab09a069340fdf88",
      "c153d34a65c47b4a62c5cacf24010975d0356b2f32c8f5da530d338816ad5de6",
      "9fc5450109e1b779f6c7ae79d56c27635c8dd426c5a9d54e2578db989b8c3b4e",
      "d12bf3732ef4af5c22fa90356af8fc50fcb40f8f2ea5c8594737a3b3d5abdbd7",
      "11030b9289bba5af65260672ab6fee88b87420acef4a1789a2073b7ec2f2a09e",
      "69cb192b8444005c8c0ceb12c846860768188cda0aec27a9c8a55cdee2123632",
      "db444c15597b5f1a03d1f9edd16e4a9f43a667cc275175dfa2b704e3bb1a9b83",
      "3fb735061abc519dfe979e54c1ee5bfad0a9d858b3315bad34bde999efd724dd"
    ];

    var input = new List(golden.length);
    for (var i = 0; i < input.length; i++) {
       input[i] = i & 0xff;
    }

    for (var i = 0; i < golden.length; i++) {
      var h = new BLAKE2s();
      h.add(input.sublist(0, i));
      expect(CryptoUtils.bytesToHex(h.close()), golden[i]);
    }

    for (var i = 0; i < goldenKeyed.length; i++) {
      var h = new BLAKE2s(key : input.sublist(0, 32));
      h.add(input.sublist(0, i));
      expect(CryptoUtils.bytesToHex(h.close()), goldenKeyed[i]);
    }

  });
}
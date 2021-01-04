import SwiftUI

struct ContentView: View {
    @State var username:String = "Vlad Koshevoy"
    @State var email:String = "v.koshevoy.ff@gmail.com"
    @State var phone:String = "4227 242 6432"
    
    @State var viewState: ViewState = .main
    var body: some View {
        if viewState == .main{
            StartView(username: $username, email: $email, phone: $phone, viewState: $viewState)
        }else if viewState == .reg{
            RegView(username: $username, email: $email, phone: $phone, viewState: $viewState)
        }else if viewState == .auth{
            AuthView(phone: $phone, viewState: $viewState)
        }else if viewState == .menu{
            MenuView(viewState: $viewState)
        }
    }
}

enum ViewState{
    case reg
    case auth
    case main
    case menu
}

struct MenuView:View{
    @Binding var viewState: ViewState
    
    @State var cards:[Card] = [
        Card(id: 0, name: "Mastercard", number: "8424 2311 5523 2423", balance: 4000),
        Card(id: 1, name: "Visa", number: "8424 2311 5534 1422", balance: 120),
        Card(id: 2, name: "Revolut", number: "8424 2311 5534 5333", balance: 4)
    ]
    @State var totalBalance:Int = 0
    
    var body: some View{
        NavigationView{
            VStack{
                HStack{
                    VStack(alignment:.leading){
                        Text("Total balance:")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                        HStack{
                            Text("$")
                                .foregroundColor(Color("opacity"))
                            Text("4124.40")
                                .foregroundColor(.white)
                        }.font(.system(size: 32))
                    }.frame(width: 160, height: 75)
                    Divider()
                        .background(Color.init("opacity"))
                        .frame(height: 55)
                        .padding([.leading, .trailing], 20)
                    VStack{
                        HStack{
                            Text("Today spent:")
                                .foregroundColor(.white)
                            HStack(spacing: 0){
                                Text("$")
                                    .foregroundColor(Color("opacity"))
                                Text("4124.40")
                                    .foregroundColor(.white)
                            }.frame(width:60, alignment: .trailing)
                        }
                        HStack{
                            Text("Today earn:")
                                .foregroundColor(.white)
                            HStack(spacing: 0){
                                Text("$")
                                    .foregroundColor(Color("opacity"))
                                Text("304.00")
                                    .foregroundColor(.white)
                            }.frame(width:60, alignment: .trailing)
                        }
                    }
                    .frame(width: 160, height: 50)
                    .font(.system(size: 14))
                }
                .padding(.top, 50)
                Spacer()
                ZStack{
                    VStack{
                        HStack{
                            Text("My cards")
                                .foregroundColor(Color("darkBlue"))
                            Spacer()
                            NavigationLink(
                                destination: AddNewCard(cards: $cards),
//                                isActive: .constant(true),
                                label: {
                                    Image(systemName: "plus")
                                        .resizable()
                                        .frame(width: 12, height: 12)
                                        .padding()
                                        .background(Color.init("blue"))
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                })
                        }.padding([.leading, .trailing], 24)
                        HStack{
                            ForEach(self.cards){card in
                                if card.name == "Mastercard"{
                                    NavigationLink(
                                        destination: cardInfoView(card: card, cards: $cards),
//                                        isActive: .constant(true),
                                        label:{
                                            Image("Master card")
                                        }
                                    )
                                }else if card.name == "Visa"{
                                    NavigationLink(
                                        destination: cardInfoView(card: card, cards: $cards),
                                        label:{
                                            Image("visa card")
                                        }
                                    )
                                }else if card.name == "Revolut"{
                                    NavigationLink(
                                        destination: cardInfoView(card: card, cards: $cards),
                                        label:{
                                            Image("revolut card")
                                        }
                                    )
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth:.infinity)
                .frame(height: 394)
                .background(Color.white)
                .cornerRadius(30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color("topColor"),Color("bottomColor")]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        }
    }
}

struct Card: Identifiable{
    var id:Int
    var name:String
    var number:String
    var balance:Int
}

struct AddNewCard:View{
    @Binding var cards:[Card]
    @State var holderName:String = "Vlad Koshevoy"
    @State var number:String = "7364 1835 5532 2233"
    @State var date:String = "01"
    @State var date2:String = "20"
    @State var cvv:String = "245"
    var body: some View{
        VStack{
            Text("Add new card")
                .foregroundColor(.white)
                .font(.system(size: 18))
                .padding(.bottom)
            ZStack{
                Image("bg card")
                VStack{
                    Spacer()
                    HStack{
                        Text(number)
                        Spacer()
                        Text(date + "/" + date2)
                    }
                }.padding(30)
            }.foregroundColor(.white)
            .frame(width: 327, height: 198)
            .padding(.bottom, 40)
            ZStack{
                VStack(spacing: 20){
                    VStack(alignment: .leading){
                        Text("Card holder name")
                            .foregroundColor(Color("search"))
                            .font(.system(size: 12))
                        TextField("", text: $holderName)
                            .font(.system(size: 16))
                    }
                    VStack(alignment: .leading){
                        Text("*Card number")
                            .foregroundColor(Color("search"))
                            .font(.system(size: 12))
                        TextField("", text: $number)
                            .font(.system(size: 16))
                    }
                    HStack{
                        VStack(alignment: .leading){
                            Text("*Expiration date")
                                .foregroundColor(Color("search"))
                                .font(.system(size: 12))
                            HStack{
                                TextField("", text: $date)
                                .font(.system(size: 16))
                                    .frame(width: 25)
                                Text("/")
                                    .foregroundColor(Color("search"))
                                TextField("", text: $date2)
                                .font(.system(size: 16))
                            }
                        }
                        VStack(alignment: .leading){
                            Text("*CVV")
                                .foregroundColor(Color("search"))
                                .font(.system(size: 12))
                            TextField("", text: $cvv)
                                .font(.system(size: 16))
                        }
                    }
                    .padding(.bottom, 40)
                    HStack{
                        Button(action: {}, label: {
                            Image(systemName: "viewfinder.circle")
                                .foregroundColor(.white)
                                .font(.system(size: 16))
                        })
                        .frame(width: 94, height: 54)
                        .background(Color.init("blue"))
                        .cornerRadius(10)
                        Button(action: {
                            let balance = Int.random(in: 1...10000)
                            let id = cards.count + 1
                            cards.append(Card(id: id, name: "Mastercard", number: number, balance: balance))
                        }, label: {
                            Text("Add card")
                                .foregroundColor(.white)
                                .font(.system(size: 16))
                        }).frame(width: 225, height: 54)
                        .background(Color.init("blue"))
                        .cornerRadius(10)
                    }
                }.padding([.leading,.trailing], 30)
            }.frame(maxWidth: .infinity)
            .frame(height:466)
            .background(Color.white)
            .cornerRadius(30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color("topColor"),Color("bottomColor")]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

struct cardInfoView:View{
    
    var card:Card
    @State var alert:Bool = false
    @Binding var cards:[Card]
    var body: some View{
        VStack{
            HStack{
                HStack{
                    Text("Earn:")
                        .foregroundColor(.white)
                    Text("$")
                        .foregroundColor(Color("opacity"))
                    Text("424.00")
                        .foregroundColor(.green)
                }
                Spacer()
                HStack{
                    Text("Spent:")
                        .foregroundColor(.white)
                    Text("$")
                        .foregroundColor(Color("opacity"))
                    Text("745.40")
                        .foregroundColor(.red)
                }
            }.padding([.leading, .trailing], 40)
            Divider()
                .frame(height: 3)
//                1169 = 100%
//                 424 = 36%
//                 745 = 64%
                .background(LinearGradient(gradient: Gradient(colors: [.green, .red]), startPoint: .init(x: 0.36, y: 0), endPoint: .init(x:0.64, y:0)))
                .padding([.leading, .trailing], 40)
                .padding(.bottom)
            ZStack{
                Image("bg card")
                VStack{
                    Spacer()
                    HStack {
                        VStack{
                            Text("Card balance:")
                                .font(.system(size: 16))
                            HStack{
                                Text("$")
                                    .foregroundColor(Color("opacity"))
                                Text("\(card.balance)")
                            }
                            .font(.system(size: 22))
                        }.foregroundColor(.white)
                        Spacer()
                    }
                    HStack{
                        Text("**** 4233")
                            .font(.system(size: 16))
                        Spacer()
                        HStack{
                            Text("Actions")
                                .font(.system(size: 12))
                            Button(action: {}, label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 14, height: 14)
                            })
                            .frame(width: 38, height: 38)
                            .background(Color.init("btn"))
                            .cornerRadius(5)
                        }
                    }.foregroundColor(.white)
                }.padding(40)
            }
            .frame(width: 327, height: 198)
            .padding(.bottom)
            HStack {
                VStack(alignment: .leading, spacing: 20){
                    NavigationLink(
                        destination: transferView(card: card, cards:$cards),
//                        isActive: .constant(true),
                        label:{
                            HStack{
                                Image(systemName: "arrow.up")
                                    .frame(width: 38, height: 38)
                                    .background(Color.init("opacity"))
                                    .cornerRadius(5)
                                Text("Transfer")
                            }
                            .foregroundColor(.white)
                        }
                    )
                    HStack{
                        Image(systemName: "arrow.down")
                            .frame(width: 38, height: 38)
                            .background(Color.init("opacity"))
                            .cornerRadius(5)
                        Text("Request")
                    }
                    .foregroundColor(.white)
                    HStack{
                        Image(systemName: "slider.horizontal.3")
                            .frame(width: 38, height: 38)
                            .background(Color.init("opacity"))
                            .cornerRadius(5)
                        Text("Set limits")
                    }
                    .foregroundColor(.white)
                    Button(action: {
                        self.alert.toggle()
                    }, label: {
                        HStack{
                            Image(systemName: "lock")
                                .frame(width: 38, height: 38)
                                .background(Color.init("opacity"))
                                .cornerRadius(5)
                            Text("Delete card")
                        }
                        .foregroundColor(.white)
                    }).alert(isPresented: $alert){
                        Alert(title: Text("Delete card"), message: Text("Are you realy want block this card?"), primaryButton: .default(
                            Text("Confirm"), action:{
                                self.cards.remove(at: card.id)
                            }),
                            secondaryButton: .cancel())
                    }
                }
                Spacer()
            }
            .padding([.leading, .trailing], 40)
            .padding(.bottom)
            ZStack{
                VStack(spacing: 40){
                    HStack{
                        Text("Recent transactions")
                            .foregroundColor(Color("darkBlue"))
                            .font(.system(size: 18))
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color("search"))
                            .frame(width: 36, height: 36)
                            .border(Color.init("search"), width: 1)
                            .cornerRadius(5)
                    }
                    HStack{
                        Text("Today, 14 August")
                        Spacer()
                        Text("- $842. 40")
                    }.foregroundColor(Color("search"))
                    HStack(spacing: 10){
                        Image(systemName: "bag")
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.init("blue"))
                            .cornerRadius(5)
                        VStack{
                            Text("Grocery store")
                                .foregroundColor(Color("darkBlue"))
                            Text("Nak market")
                                .foregroundColor(Color("search"))
                        }
                        Spacer()
                        Text("- $400. 40")
                            .foregroundColor(.red)
                    }
                }.padding([.leading, .trailing], 24)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 253)
            .background(Color.white)
            .cornerRadius(30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color("topColor"),Color("bottomColor")]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

struct transferView: View{
    var card: Card
    @Binding var cards:[Card]
    @State var number: String = "8424 2311 5534 1422"
    @State var amount:String = "4000"
    var body: some View{
        VStack{
            HStack(spacing: 50){
                Spacer()
                HStack(spacing:5){
                    if card.name == "Mastercard"{
                        Image("master card logo")
                        Text("Mastercard")
                    }else if card.name == "Visa"{
                        Image("visa logo")
                        Text("Visa")
                    }else if card.name == "Revolut"{
                        Image("Revolut-logo")
                        Text("Revolut")
                    }
                }
                Text("*** 2423")
            }.padding([.leading,.trailing], 24)
            .foregroundColor(.white)
            ZStack{
                VStack(spacing: 40){
                    HStack{
                        Text("Make transfer")
                            .foregroundColor(Color("darkBlue"))
                            .font(.system(size:18))
                        Spacer()
                    }
                    HStack(spacing: 20){
                        VStack(alignment:.leading){
                            Text("To")
                                .foregroundColor(Color("search"))
                            TextField("", text: $number)
                                .frame(width: 300)
                        }
                        Image("visa logo")
                    }
                    HStack(spacing: 20){
                        VStack(alignment:.leading){
                            Text("From")
                                .foregroundColor(Color("search"))
                            Text(card.number)
                                .frame(width: 300, alignment:.leading)
                        }
                        Image("master card logo")
                    }
                    HStack(spacing: 20){
                        VStack(alignment:.leading){
                            Text("Amount")
                                .foregroundColor(Color("search"))
                            TextField("", text: $amount)
                        }
                        Image("usd")
                    }
                    Button(action:{
                        self.cards[card.id].balance -= Int(amount)!
                        if self.cards[card.id].balance <= 0{
                            print("Бомж ебанный")
                        }
                        self.cards[1].balance += Int(amount)!
                    },label:{
                        Text("Make transfer")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    })
                    .frame(width: 327, height: 54)
                    .background(Color.init("blue"))
                    .cornerRadius(10)
                }
                .padding([.leading, .trailing], 24)
            }
            .frame(maxWidth:.infinity)
            .frame(height: 500)
            .background(Color.white)
            .cornerRadius(30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color("topColor"),Color("bottomColor")]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

struct StartView: View{
    @Binding var username:String
    @Binding var email:String
    @Binding var phone:String
    
    @Binding var viewState:ViewState
    var body: some View{
        ZStack{
            Image("bg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack{
                    Image("logo")
                        .resizable()
                        .frame(width: 52, height: 49)
                        .padding(.bottom, 20)
                    Text("Quantum Wallet")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                VStack(spacing: 20){
                    Text("Keep your cards in one place")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .bold))
                        .padding([.leading, .trailing], 77)
                    Text("Keep your cards in one safe place.We can secure your information")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 16))
                        .padding([.leading, .trailing], 44)
                    HStack{
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(Color("blue"))
                        Circle()
                            .frame(width: 4, height: 4)
                            .foregroundColor(.white)
                        Circle()
                            .frame(width: 4, height: 4)
                            .foregroundColor(.white)
                    }
                }
                VStack(spacing: 20){
                    Button(action: {
                        self.viewState = .reg
                    }, label: {
                        Text("Get Started")
                            .foregroundColor(.white)
                    })
                    .frame(width: 327, height: 54)
                    .background(Color("blue"))
                    .cornerRadius(14)
                    Button(action: {
                        self.viewState = .auth
                    }, label: {
                        Text("Log In")
                    })
                    .frame(width: 327, height: 54)
                    .background(Color.init("gray"))
                    .cornerRadius(14)
                    .foregroundColor(.white)
                }
            }
        }
    }
}

struct RegView: View{
    @Binding var username:String
    @Binding var email:String
    @Binding var phone:String
    
    @Binding var viewState: ViewState
    var body: some View{
        ZStack{
            Image("bg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack(alignment:.leading){
                Image("logo")
                    .resizable()
                    .frame(width: 50, height: 47)
                    .padding(.leading, 24)
                VStack(spacing: 20){
                    Text("Idite nahui (:")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .bold))
                        .padding(.leading, 24)
                        .padding(.trailing, 206)
                    Text("Please register in our application to continue work with your wallets")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .padding(.leading, 24)
                        .padding(.trailing, 81)
                        .multilineTextAlignment(.leading)
                }
                ZStack{
                    VStack(spacing: 20){
                        VStack(alignment: .leading){
                            Text("Username")
                                .foregroundColor(Color.init("blue"))
                            TextField("", text: $username)
                                .font(.system(size: 16))
                        }
                        .frame(height: 66)
                        .padding([.leading, .trailing], 24)
                        .cornerRadius(12)
                        VStack(alignment: .leading){
                            Text("E-mail")
                                .foregroundColor(Color.init("blue"))
                            TextField("", text: $email)
                                .font(.system(size: 16))
                        }
                        .frame(height: 66)
                        .padding([.leading, .trailing], 24)
                        .cornerRadius(12)
                        VStack(alignment: .leading){
                            Text("Phone number")
                                .foregroundColor(Color.init("blue"))
                            HStack(spacing: 10){
                                Text("+01")
                                    .padding(.leading, 24)
                                    .foregroundColor(Color.init("blue"))
                                    .opacity(0.5)
                                TextField("", text: $phone)
                                Image("country")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .padding(.trailing, 24)
                            }
                        }
                        .frame(height: 66)
                        .padding([.leading, .trailing], 24)
                        .cornerRadius(12)
                        Button(action: {
                            self.viewState = .auth
                        }, label: {
                            Text("Get Started")
                                .foregroundColor(.white)
                        })
                        .frame(width: 327, height: 54)
                        .background(Color.init("blue"))
                        .cornerRadius(14)
                        HStack(spacing: 5){
                            Text("Alreay have an account?")
                                .font(.system(size: 14))
                                .foregroundColor(Color.init("blue"))
                                .opacity(0.5)
                            Button(action: {
                                self.viewState = .auth
                            }, label: {
                                Text("Log In")
                                    .foregroundColor(Color.init("blue"))
                            })
                        }
                    }
                }
                .frame(height: 536)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(30)
            }
        }
    }
}

struct AuthView: View{
    @Binding var phone:String
    
    @Binding var viewState: ViewState
    var body: some View{
        NavigationView{
            ZStack{
                Image("bg")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment:.leading){
                    Image("logo")
                        .resizable()
                        .frame(width: 47, height: 50)
                        .padding(.leading, 24)
                    VStack(alignment:.leading, spacing: 20){
                        Text("Toje tuda!")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                        Text("Please enter your phone number to continue")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .padding(.trailing, 184)
                            .multilineTextAlignment(.leading)
                    }.padding(.leading, 24)
                    ZStack{
                        VStack(spacing: 20){
                            VStack{
                                Text("Phone number")
                                    .foregroundColor(Color("blue"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                HStack{
                                    Text("+01")
                                        .foregroundColor(Color("blue"))
                                    TextField("", text: $phone)
                                    Image("country")
                                        .resizable()
                                        .frame(width:28, height: 28)
                                }.font(.system(size: 16))
                            }.frame(width: 327, height: 66)
                            NavigationLink(
                                destination: VerificationView(phone: $phone, viewState: $viewState),
                                label: {
                                    Text("Log In")
                                        .foregroundColor(.white)
                                })
                                .frame(width: 327, height: 54)
                                .background(Color.init("blue"))
                                .cornerRadius(14)
                            HStack{
                                Text("Still have no account?")
                                    .foregroundColor(Color("blue"))
                                Button(action: {
                                    self.viewState = .reg
                                }, label: {
                                    Text("Register")
                                })
                            }.font(.system(size: 14))
                        }
                    }.frame(maxWidth: .infinity)
                    .frame(height: 372)
                    .background(Color.white)
                    .cornerRadius(30)
                }
                .frame(maxWidth: .infinity, alignment:.leading)
            }
        }
    }
}

struct VerificationView: View{
    @Binding var phone:String
    @Binding var viewState: ViewState
    @State var code:[String] = Array(repeating: "*", count: 6)
    var body: some View{
        ZStack{
            Image("bg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 90){
                VStack(alignment:.leading, spacing: 20){
                    Text("Phone verification")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                    Text("We send verification code to yout number:" + " +01" + " " + phone)
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                        .frame(width: 250, height: 48)
                }
                .padding(.leading, 24)
                .frame(maxWidth: .infinity, alignment:.leading)
                HStack(spacing: 20){
                    ForEach(0..<code.count){i in
                        VStack{
                            Text(code[i])
                                .font(.system(size: 18))
                            Divider()
                                .frame(width: 33, height: 2)
                                .background(Color.white)
                        }
                    }
                }
                .foregroundColor(.white)
                .frame(height: 37)
                .frame(maxWidth: .infinity)
                ZStack{
                    VStack(spacing: 20){
                        LazyVGrid(columns: [GridItem(.fixed(120)),GridItem(.fixed(120)),GridItem(.fixed(120))] ){
                            LazyHGrid(rows: [GridItem(.fixed(50)),GridItem(.fixed(50)),GridItem(.fixed(50)),GridItem(.fixed(50))] ) {
                                Button(action:{
                                    var i = 0
                                    while code[i] != "*"{
                                        i += 1
                                    }
                                    if i < code.count{
                                        code[i] = "1"
                                    }
                                },label:{
                                    Text("1")
                                }).frame(width: 120, height: 50)
                                Button(action:{
                                    var i = 0
                                    while code[i] != "*"{
                                        i += 1
                                    }
                                    if i < code.count{
                                        code[i] = "4"
                                    }
                                },label:{
                                    Text("4")
                                }).frame(width: 120, height: 50)
                                Button(action:{
                                    var i = 0
                                    while code[i] != "*"{
                                        i += 1
                                    }
                                    if i < code.count{
                                        code[i] = "7"
                                    }
                                },label:{
                                    Text("7")
                                }).frame(width: 120, height: 50)
                            }
                            LazyHGrid(rows: [GridItem(.fixed(50)),GridItem(.fixed(50)),GridItem(.fixed(50)),GridItem(.fixed(50))] ) {
                                Button(action:{
                                    var i = 0
                                    while code[i] != "*"{
                                        i += 1
                                    }
                                    if i < code.count{
                                        code[i] = "2"
                                    }
                                },label:{
                                    Text("2")
                                }).frame(width: 120, height: 50)
                                Button(action:{
                                    var i = 0
                                    while code[i] != "*"{
                                        i += 1
                                    }
                                    if i < code.count{
                                        code[i] = "5"
                                    }
                                },label:{
                                    Text("5")
                                }).frame(width: 120, height: 50)
                                Button(action:{
                                    var i = 0
                                    while code[i] != "*"{
                                        i += 1
                                    }
                                    if i < code.count{
                                        code[i] = "8"
                                    }
                                },label:{
                                    Text("8")
                                }).frame(width: 120, height: 50)
                                Button(action:{
                                    var i = 0
                                    while code[i] != "*"{
                                        i += 1
                                    }
                                    if i < code.count{
                                        code[i] = "0"
                                    }
                                },label:{
                                    Text("0")
                                }).frame(width: 120, height: 50)
                            }
                            LazyHGrid(rows: [GridItem(.fixed(50)),GridItem(.fixed(50)),GridItem(.fixed(50)),GridItem(.fixed(50))] ) {
                                Button(action:{
                                    var i = 0
                                    while code[i] != "*"{
                                        i += 1
                                    }
                                    if i < code.count{
                                        code[i] = "3"
                                    }
                                },label:{
                                    Text("3")
                                }).frame(width: 120, height: 50)
                                Button(action:{
                                    var i = 0
                                    while code[i] != "*"{
                                        i += 1
                                    }
                                    if i < code.count{
                                        code[i] = "6"
                                    }
                                },label:{
                                    Text("6")
                                }).frame(width: 120, height: 50)
                                Button(action:{
                                    var i = 0
                                    while code[i] != "*"{
                                        i += 1
                                    }
                                    if i < code.count{
                                        code[i] = "9"
                                    }
                                },label:{
                                    Text("9")
                                }).frame(width: 120, height: 50)
                                Button(action:{
                                    var i = self.code.count-1
                                    while code[i] == "*"{
                                        i -= 1
                                    }
                                    if i >= 0{
                                        self.code[i] = "*"
                                    }
                                },label:{
                                    Image(systemName: "delete.left")
                                }).frame(width: 120, height: 50)
                            }
                        }
                        .padding(.bottom, 20)
                        Button(action:{
                            self.viewState = .menu
                        },label:{
                            Text("Done")
                                .foregroundColor(.white)
                        })
                        .frame(width: 327, height: 54)
                        .background(Color.init("blue"))
                        .cornerRadius(14)
                        Button(action:{
                            
                        },label:{
                            Text("Resend code")
                                .foregroundColor(Color("blue"))
                        })
                        .frame(width: 327, height: 54)
                        .background(Color.white)
                        .border(Color.init("blue"), width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .cornerRadius(14)
                    }
                    
                }
                .frame(height: 484)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(30)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

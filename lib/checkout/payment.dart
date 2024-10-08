
import 'package:everlane/checkout/address_creation.dart';
import 'package:everlane/checkout/address_list.dart';
import 'package:everlane/checkout/ordersuccess.dart';
import 'package:everlane/checkout/pickuplocations.dart';
import 'package:everlane/checkout/webviewscreen.dart';
import 'package:everlane/data/models/disastermodel.dart';
import 'package:everlane/data/models/pickupmodel.dart';
import 'package:everlane/widgets/customappbar.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/address/address_bloc.dart';
import '../bloc/cart/cart_bloc.dart';
import '../data/models/addressmodel.dart';
import '../data/models/cartmodel.dart';
import '../widgets/customcolor.dart';
import 'orderitem.dart';
  UserAddress? selectedAddress;
class PaymentScreen extends StatefulWidget {
  final UserAddress? address;
  final Disaster? disaster;
  late final PickupLocation? pickupLocation;
  final List<PickupLocation>? pickupLocations;


  // late final PickupLocation? pickuplocations;
  PaymentScreen({super.key,  this.address,  this.pickupLocation,  this.pickupLocations, this.disaster, });


  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isLoading = false;
  UserAddress? deliveryAddress;
  PickupLocation? selectedLocation;
  Disaster? selectedDisaster;
  List<Cart> carts=[];
  String selectedPaymentMethod = "ONLINE";
  String? selectedOrderType;
   bool isSelected=false;
  bool _isAddressSelected = false;
  String disasterName = '';
  String disasterLocation = '';
  List<PickupLocation> pickuplocations=[];
  List<Disaster> disasters=[];



   bool _isVisible=true;

   void _toggleVisibility() {
     setState(() {
       _isVisible = !_isVisible;
     });
   }
  Future<UserAddress?> _showModalSheet(BuildContext context)async {

    List<UserAddress>useradress=[];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child:   MultiBlocListener(
              listeners: [
                BlocListener<AddressBloc, AddressState>(
                  listener: (context, state) {
                    print(state);
                    if (state is AddressLoading) {
                      setState(() {

                      });
                    }
                    else if (state is AddressLoaded) {
                      setState(() {
                        //BlocProvider.of<AddressBloc>(context).add(FetchUserAddresses());
                      });
                      useradress = state.userAddresses;
                      //final useraddress = state.userAddresses;
                      print("adding to addresslist");
                    }
                    else if (state is DeleteAdresssuccess) {
                      setState(() {
                        useradress.removeWhere((item) => item.id == state.addressid);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Item deleted successfully')),
                      );

                    }else if (state is AddressError) {
                      // Dismiss loading indicator and show error message
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }

                  },
                ),
              ],
              child:
             SingleChildScrollView(
               child: Column(
               
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 30.w),
                      child: Container(
                        height: 80.h,
                        width: 400.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Create Address",style: CustomFont().subtitleText,),
                            SizedBox(width: 20,),
                            IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressScreen()));
                            }, icon: Icon(Icons.add,size: 30.sp,)),
                          ],
                        ),
                      ),
                    ),
                    useradress.isEmpty?Center(child: Text("No address available"),): ListView.builder(
                      shrinkWrap: true,
                padding: EdgeInsets.all(10),
                  itemCount: useradress.length,
                  itemBuilder: (context,index){
                    print(useradress.length);
                    print(useradress[index].address);
                    // final address = state.userAddresses[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.w),
                        child: InkWell(
                          onTap: (){
                            setState((){});
                            selectedAddress=useradress[index];
                            Navigator.pop(context, useradress[index]);

                            // Navigator.pop(context, MaterialPageRoute(builder: (Context)=>PaymentScreen(address: useradress[index])));
                          },
                          child: Container(
                            height: 150.h,
                            width: 400.w,
                            decoration: BoxDecoration(
                              color: Colors.white30,
                              border: Border.all(color: Colors.grey.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(useradress[index].address),
                                      Text(useradress[index].state),
                                      Text(useradress[index].city),
                                      Text(useradress[index].pincode),
                                      SizedBox(
                                        height: 20.h,
                                          child: Text(useradress[index].mobile)),
                                      Text(useradress[index].locality),
               
                                    ],
                                  ),
                                  IconButton(onPressed: (){
                                    BlocProvider.of<AddressBloc>(context)
                                        .add(DeleteAddress(useradress[index].id),
                                    );
                                  }, icon: Icon(Icons.delete))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  ],
                ),
             ),

            ),
          );
        },
      ),
    ).whenComplete(() {
      setState(() {


      });
    },);
  }

  void _selectPaymentMethod(String method) {
    setState(() {
      if (selectedOrderType == "donate") {
        selectedPaymentMethod = "ONLINE";
      } else {
        if (selectedPaymentMethod == method) {
          selectedPaymentMethod = "ONLINE";
        } else {
          selectedPaymentMethod = method;
        }
      }
    });
  }


  void _selectOrderType(String type) {
    setState(() {
      if (selectedOrderType == type) {
        selectedOrderType = null; // Deselect if already selected
      } else {
        selectedOrderType = type; // Select the tapped order type
      }
    });
  }

  Future<void> _selectDisasterAddress() async {
    final PickupLocation? selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Pickuplocations()),
    );

    if (selectedLocation != null) {
      setState(() {
        // Set address fields with selected pickup location data
        widget.pickupLocation = selectedLocation;
        selectedOrderType = "donate";
        _isAddressSelected = true;
      });
    }
  }


  @override
  void initState() {
  context.read<CartBloc>().add(FetchCartData());
  WidgetsBinding.instance.addPostFrameCallback((_) {
    BlocProvider.of<AddressBloc>(context).add(Fetchpickuplocations());
  });
  BlocProvider.of<AddressBloc>(context).add(FetchDisaster());
  selectedLocation = selectedLocation ?? widget.pickupLocations?.first;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        backgroundColor: CustomColor.primaryColor,
        onPressed: () {
          print("Button pressed");
          print("selectedOrderType: $selectedOrderType");
          print("selectedPaymentMethod: $selectedPaymentMethod");
          print("selectedLocation: $selectedLocation");
          print("selectedAddress: $selectedAddress");
          if (selectedPaymentMethod.isNotEmpty) {
            if (selectedOrderType == "donate" && selectedLocation == null) {
              print("widget.pickupLocation${selectedLocation}");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please select a pickup location')),
              );
            } else if (selectedOrderType == "delivery" && selectedAddress == null) {
              print("selectedAddress${selectedAddress}");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please select a delivery address')),
              );
            } else if (carts.isNotEmpty) {
              setState(() {
                _isLoading = true; // Set loading to true
              });
              if (selectedPaymentMethod == "COD") {
                context.read<CartBloc>().add(PlaceOrder(
                  deliveryAddressId: selectedAddress?.id ?? 0,
                  orderType: selectedOrderType??"",
                  paymentMethod: selectedPaymentMethod,
                ));
                print("llllllllllll${widget.address?.id ?? 0}");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Order placed successfully!')),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OrderSuccessScreen()),
                );
              } else if (selectedPaymentMethod == "ONLINE") {
                // Trigger the online payment processing
                context.read<CartBloc>().add(PlaceOrder(
                  deliveryAddressId: selectedAddress?.id ?? 0,
                  orderType: selectedOrderType??'',
                  paymentMethod: selectedPaymentMethod,
                  pickupid: selectedLocation?.id??0,
                  //pickupid: widget.pickupLocation?.id??0,
                  disasterid: selectedDisaster?.id??0
                  //disasterid: widget.disaster?.id??0,
                ));
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Your cart is empty. Please add items to the cart before placing an order.')),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please select a payment method'),),
            );
          }
        },
        label: Container(
          height: 30.h,
          width: 150.w,
          decoration: BoxDecoration(
            color: CustomColor.primaryColor,
          ),
          child: Center(
            child: _isLoading
                ? CircularProgressIndicator(color: Colors.white) : Text("Place Order", style: CustomFont().buttontext),
          ),
        ),
        icon: Icon(
          Icons.shopping_bag_outlined,
          size: 20.sp,
          color: CustomColor.buttoniconColor,
        ),
      ),


      backgroundColor:  Color(0xFFEFEFEF),
      appBar: PreferredSize(preferredSize: Size.fromHeight(50), child: CustomAppBar(text: "Confirm Order",
        leading: InkWell(
            onTap: (){
              // final navigationProvider = Provider.of<NavigationProvider>(context, listen: false);
              // navigationProvider.updateScreenIndex(0);
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => AddressList()),
              );
            },
            child: Icon(Icons.arrow_back)),)),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CartBloc, CartState>(
            listener: (context, state) {
              print(state);
              if (state is CartLoading) {
                // Handle loading state
              } else if (state is CartLoaded) {
                carts = state.carts;
                print("Cart Loaded: ${carts.length} carts loaded.");
                setState(() {});
              }
              else if (state is PlaceOrderSuccess) {
                final approvalUrl = state.approvalUrl;
                print("apprival url in place order succresss${approvalUrl}");
                if (selectedPaymentMethod == "ONLINE") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebviewScreen(approvalUrl: approvalUrl),
                    ),
                  );
                } else if (selectedPaymentMethod == "COD") {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => OrderSuccessScreen()),
                  );
                }
              }


              else if (state is CartError) {
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),
          BlocListener<AddressBloc, AddressState>(
            listener: (context, state) {
              print(state);
              if (state is Pickuploading) {

              }
              else if (state is Pickuploaded) {
                print(state);
                pickuplocations = state.pickuplocations;
                setState(() {

                });
                //final useraddress = state.userAddresses;
                print("adding to pickuplocations");
                print("Pickuploaded state received with ${pickuplocations.length} locations");
              }
              else if (state is DisasterLoaded) {
                setState(() {

                });
                disasters = state.disaster;
                print(disasters);
                //final useraddress = state.userAddresses;
                print("adding to disaster");
              }

            },
          ),
        ],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // SizedBox(
                //   width: 400.w,
                //     child: CartItemCard(title: cart,)),
                if (_isVisible)
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: carts.isEmpty ? 0 : carts.length,
                    itemBuilder: (context, cartIndex) {
                      if (carts.isEmpty) {
                        return Center(child: Text("No items in cart"));
                      }
                      return Column(
                        children: carts[cartIndex].items.map((item) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OrderItem(
                              title: item.productName,
                              price: item.productPrice,
                              image: item.productImage,
                              itemcount: item.quantity.toString(),
                              size: item.size,

                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),

                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 150.w),
                  child: TextButton(
                    onPressed: _toggleVisibility,
                    child: Text(_isVisible ? 'Hide' : 'View ',style: GoogleFonts.questrial(
                        textStyle: TextStyle(
                          color: Color(0xFF973d93),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        )),),
                  ),
                ),
                SizedBox(height: 20.h,),
                Padding(
                  padding:  EdgeInsets.only(left: 10.w,right: 10.w),
                  child: Text("OrderType",style: CustomFont().subtitleText,),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 50.h,
                    //width: 380.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Buyformyself",style: CustomFont().bodyText,),
                        IconButton(onPressed: (){
                          _selectOrderType("delivery");
                        },
                            icon: Icon(selectedOrderType == "delivery" ? Icons.check_circle : Icons.circle_outlined))

                      ],
                    ),


                  ),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 50.h,
                    //width: 380.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Donate",style: CustomFont().bodyText,),
                        IconButton(onPressed: (){
                          _selectOrderType("donate");
                        }, icon: Icon(selectedOrderType == "donate" ? Icons.check_circle : Icons.circle_outlined))
                        ,
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
               Padding(
                  padding:  EdgeInsets.only(left: 10.w,right: 10.w),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      selectedOrderType=="delivery"? Text("Delivery Address",style: CustomFont().subtitleText,):selectedOrderType=="donate"?
                      Text("Pickup Location",style: CustomFont().subtitleText,):SizedBox(),

                      TextButton(
                        onPressed: ()async{
                          print("hsdklmnklcm");
                          BlocProvider.of<AddressBloc>(context).add(FetchUserAddresses());
                         // final UserAddress? selectedAddress = await _showModalSheet(context);
                          _showModalSheet(context).whenComplete(() {
                            setState(() {

                            });
                          },);

                        // if (selectedOrderType == "delivery") {
                        //   _showModalSheet(context);

                        //   // Navigator.push(
                        //   //   context,
                        //   //   MaterialPageRoute(builder: (context) => AddressList()),
                        //   // );
                        // }
                        // else if (selectedOrderType == "donate") {
                        //   // _selectDisasterAddress(); // Navigate to DisasterList and select disaster address
                        // }
                      },

                          child: selectedOrderType == "delivery"?Text("Choose",style: GoogleFonts.questrial(color: Colors.purple,),):Text(""),
                      )],
                  ),
                ),
                SizedBox(height: 8.h,),
                if (selectedOrderType == "delivery")
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.w),
                    child: Container(
                      height: 150.h,
                      width: 400.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child:selectedAddress != null ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(selectedAddress?.address??""),
                            Text(selectedAddress?.state??""),
                            Text(selectedAddress?.city??""),
                            Text(selectedAddress?.pincode??""),
                            Text(selectedAddress?.mobile??""),
                            Text(selectedAddress?.locality??""),
                            //Text(widget.pickupLocation?.city??""),
                          ],
                        ): Center(child: Text('No Address Selected')),
                      ),
                    ),
                  )
                else if (selectedOrderType == "donate")
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.w),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          // padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 20.h),
                            height: 50.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: DropdownButton<PickupLocation>(
                              value: selectedLocation,
                              hint: Text('Select pickuplocation'),
                              dropdownColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              underline: SizedBox(),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: pickuplocations.map((PickupLocation location) {
                                return DropdownMenuItem<PickupLocation>(
                                  value: location,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: 300.w, // Set a maximum width to prevent overflow
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${location.city}, ${location.address}',
                                            overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (PickupLocation? newValue) {
                                setState(() {
                                  selectedLocation = newValue!;
                                //  widget.pickupLocation = newValue;
                                });
                              },
                            ),
                        ),


                      ],
                    ),

                  ),
                SizedBox(height: 8.h,),
     if (selectedOrderType == "donate")  Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.all(12),
                          height: 50.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: DropdownButton<Disaster>(
                            value: selectedDisaster,
                            hint: Text('Select a disaster'),
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            underline: SizedBox(),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: disasters.map((Disaster disaster) {
                              return DropdownMenuItem<Disaster>(
                                value: disaster,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 300.w, // Set a maximum width to prevent overflow
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${disaster.name}, ${disaster.location}',
                                          overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //child: Text('${disaster.name}, ${disaster.location}'),
                              );
                            }).toList(),
                            onChanged: (Disaster? newValue) {
                              setState(() {
                                selectedDisaster = newValue!;
                              });
                            },
                          )
                      ),
                    ],
                  ),

                ),
                SizedBox(height: 8.h,),

            SizedBox(height: 8.h,),
                Padding(
                  padding:  EdgeInsets.only(left: 10.w,right: 10.w),
                  child: Text("Payment Method",style: CustomFont().subtitleText,),
                ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
              child: Container(
              padding: EdgeInsets.all(10),
              height: 50.h,
              //width: 380.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Cash on delivery",style: CustomFont().bodyText,),
             IconButton(onPressed: (){
               _selectPaymentMethod("COD");
             },
                 icon:Icon(selectedPaymentMethod == "COD" ? Icons.check_circle : Icons.circle_outlined))
                ],
              ),
                  ),
            ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 50.h,
                    //width: 380.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Paypal",style: CustomFont().bodyText,),
                        IconButton(onPressed: (){
                          _selectPaymentMethod("ONLINE");
                        }, icon: Icon(selectedPaymentMethod == "ONLINE" ? Icons.check_circle : Icons.circle_outlined)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),

                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child:  Container(
                      height: 60.h,
                      width: 450.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child:
                        Row(
                          children: [
                            SizedBox(
                              width: 100.w,
                              child: Text(
                                "Total",
                                style: CustomFont().bodyText,
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                              child: Text(
                                ":",
                                style: CustomFont().subtitleText,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            SizedBox(
                              width: 100.w,
                              child: Text(
                                carts.isNotEmpty ? carts[0].totalPrice ??'' : '0.0',
                                style: CustomFont().bodyText,
                              ),
                            ),
                            // _buildRow(context, "Discount", "00"),
                            // SizedBox(height: 10.h),
                            // _buildRow(context, "Total", carts.isNotEmpty ? carts[0].totalPrice ??'' : '0.0',),
                          ],
                        ),
                      ),
                    ),
                ),
                SizedBox(height: 80.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }

   Widget _buildRow(BuildContext context, String label, String value) {
     return Row(
       children: [
         SizedBox(
           width: 100.w,
           child: Text(
             label,
             style: CustomFont().bodyText,
           ),
         ),
         SizedBox(
           width: 20.w,
           child: Text(
             ":",
             style: CustomFont().subtitleText,
           ),
         ),
         SizedBox(width: 10.w),
         SizedBox(
           width: 100.w,
           child: Text(
             value,
             style: CustomFont().bodyText,
           ),
         ),
       ],
     );
   }
}

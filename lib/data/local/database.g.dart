// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _orderNumberMeta =
      const VerificationMeta('orderNumber');
  @override
  late final GeneratedColumn<String> orderNumber = GeneratedColumn<String>(
      'order_number', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _orderDateMeta =
      const VerificationMeta('orderDate');
  @override
  late final GeneratedColumn<DateTime> orderDate = GeneratedColumn<DateTime>(
      'order_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deliveryDateMeta =
      const VerificationMeta('deliveryDate');
  @override
  late final GeneratedColumn<DateTime> deliveryDate = GeneratedColumn<DateTime>(
      'delivery_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('newOrder'));
  static const VerificationMeta _totalPriceMeta =
      const VerificationMeta('totalPrice');
  @override
  late final GeneratedColumn<double> totalPrice = GeneratedColumn<double>(
      'total_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _initialPaymentMeta =
      const VerificationMeta('initialPayment');
  @override
  late final GeneratedColumn<double> initialPayment = GeneratedColumn<double>(
      'initial_payment', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _initialPaymentMethodMeta =
      const VerificationMeta('initialPaymentMethod');
  @override
  late final GeneratedColumn<String> initialPaymentMethod =
      GeneratedColumn<String>('initial_payment_method', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('cash'));
  static const VerificationMeta _clientNameMeta =
      const VerificationMeta('clientName');
  @override
  late final GeneratedColumn<String> clientName = GeneratedColumn<String>(
      'client_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _clientPhoneMeta =
      const VerificationMeta('clientPhone');
  @override
  late final GeneratedColumn<String> clientPhone = GeneratedColumn<String>(
      'client_phone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _clientAddressMeta =
      const VerificationMeta('clientAddress');
  @override
  late final GeneratedColumn<String> clientAddress = GeneratedColumn<String>(
      'client_address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _abayaTypeMeta =
      const VerificationMeta('abayaType');
  @override
  late final GeneratedColumn<String> abayaType = GeneratedColumn<String>(
      'abaya_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _abayaNumberMeta =
      const VerificationMeta('abayaNumber');
  @override
  late final GeneratedColumn<String> abayaNumber = GeneratedColumn<String>(
      'abaya_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _orderNotesMeta =
      const VerificationMeta('orderNotes');
  @override
  late final GeneratedColumn<String> orderNotes = GeneratedColumn<String>(
      'order_notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _orderSourceMeta =
      const VerificationMeta('orderSource');
  @override
  late final GeneratedColumn<String> orderSource = GeneratedColumn<String>(
      'order_source', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('whatsapp'));
  static const VerificationMeta _orderSourceOtherMeta =
      const VerificationMeta('orderSourceOther');
  @override
  late final GeneratedColumn<String> orderSourceOther = GeneratedColumn<String>(
      'order_source_other', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _walletNameMeta =
      const VerificationMeta('walletName');
  @override
  late final GeneratedColumn<String> walletName = GeneratedColumn<String>(
      'wallet_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _walletNameOtherMeta =
      const VerificationMeta('walletNameOther');
  @override
  late final GeneratedColumn<String> walletNameOther = GeneratedColumn<String>(
      'wallet_name_other', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _measurementTypeMeta =
      const VerificationMeta('measurementType');
  @override
  late final GeneratedColumn<String> measurementType = GeneratedColumn<String>(
      'measurement_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('general'));
  static const VerificationMeta _generalSizeMeta =
      const VerificationMeta('generalSize');
  @override
  late final GeneratedColumn<String> generalSize = GeneratedColumn<String>(
      'general_size', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _measurementNotesMeta =
      const VerificationMeta('measurementNotes');
  @override
  late final GeneratedColumn<String> measurementNotes = GeneratedColumn<String>(
      'measurement_notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lengthMeta = const VerificationMeta('length');
  @override
  late final GeneratedColumn<double> length = GeneratedColumn<double>(
      'length', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _shoulderMeta =
      const VerificationMeta('shoulder');
  @override
  late final GeneratedColumn<double> shoulder = GeneratedColumn<double>(
      'shoulder', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sleeveMeta = const VerificationMeta('sleeve');
  @override
  late final GeneratedColumn<double> sleeve = GeneratedColumn<double>(
      'sleeve', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _chestMeta = const VerificationMeta('chest');
  @override
  late final GeneratedColumn<double> chest = GeneratedColumn<double>(
      'chest', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _waistMeta = const VerificationMeta('waist');
  @override
  late final GeneratedColumn<double> waist = GeneratedColumn<double>(
      'waist', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _isArchivedMeta =
      const VerificationMeta('isArchived');
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
      'is_archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_archived" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        orderNumber,
        orderDate,
        deliveryDate,
        status,
        totalPrice,
        initialPayment,
        initialPaymentMethod,
        clientName,
        clientPhone,
        clientAddress,
        abayaType,
        abayaNumber,
        orderNotes,
        orderSource,
        orderSourceOther,
        walletName,
        walletNameOther,
        measurementType,
        generalSize,
        measurementNotes,
        length,
        shoulder,
        sleeve,
        chest,
        waist,
        isArchived,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(Insertable<Order> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_number')) {
      context.handle(
          _orderNumberMeta,
          orderNumber.isAcceptableOrUnknown(
              data['order_number']!, _orderNumberMeta));
    } else if (isInserting) {
      context.missing(_orderNumberMeta);
    }
    if (data.containsKey('order_date')) {
      context.handle(_orderDateMeta,
          orderDate.isAcceptableOrUnknown(data['order_date']!, _orderDateMeta));
    } else if (isInserting) {
      context.missing(_orderDateMeta);
    }
    if (data.containsKey('delivery_date')) {
      context.handle(
          _deliveryDateMeta,
          deliveryDate.isAcceptableOrUnknown(
              data['delivery_date']!, _deliveryDateMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('total_price')) {
      context.handle(
          _totalPriceMeta,
          totalPrice.isAcceptableOrUnknown(
              data['total_price']!, _totalPriceMeta));
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('initial_payment')) {
      context.handle(
          _initialPaymentMeta,
          initialPayment.isAcceptableOrUnknown(
              data['initial_payment']!, _initialPaymentMeta));
    }
    if (data.containsKey('initial_payment_method')) {
      context.handle(
          _initialPaymentMethodMeta,
          initialPaymentMethod.isAcceptableOrUnknown(
              data['initial_payment_method']!, _initialPaymentMethodMeta));
    }
    if (data.containsKey('client_name')) {
      context.handle(
          _clientNameMeta,
          clientName.isAcceptableOrUnknown(
              data['client_name']!, _clientNameMeta));
    } else if (isInserting) {
      context.missing(_clientNameMeta);
    }
    if (data.containsKey('client_phone')) {
      context.handle(
          _clientPhoneMeta,
          clientPhone.isAcceptableOrUnknown(
              data['client_phone']!, _clientPhoneMeta));
    } else if (isInserting) {
      context.missing(_clientPhoneMeta);
    }
    if (data.containsKey('client_address')) {
      context.handle(
          _clientAddressMeta,
          clientAddress.isAcceptableOrUnknown(
              data['client_address']!, _clientAddressMeta));
    }
    if (data.containsKey('abaya_type')) {
      context.handle(_abayaTypeMeta,
          abayaType.isAcceptableOrUnknown(data['abaya_type']!, _abayaTypeMeta));
    } else if (isInserting) {
      context.missing(_abayaTypeMeta);
    }
    if (data.containsKey('abaya_number')) {
      context.handle(
          _abayaNumberMeta,
          abayaNumber.isAcceptableOrUnknown(
              data['abaya_number']!, _abayaNumberMeta));
    }
    if (data.containsKey('order_notes')) {
      context.handle(
          _orderNotesMeta,
          orderNotes.isAcceptableOrUnknown(
              data['order_notes']!, _orderNotesMeta));
    }
    if (data.containsKey('order_source')) {
      context.handle(
          _orderSourceMeta,
          orderSource.isAcceptableOrUnknown(
              data['order_source']!, _orderSourceMeta));
    }
    if (data.containsKey('order_source_other')) {
      context.handle(
          _orderSourceOtherMeta,
          orderSourceOther.isAcceptableOrUnknown(
              data['order_source_other']!, _orderSourceOtherMeta));
    }
    if (data.containsKey('wallet_name')) {
      context.handle(
          _walletNameMeta,
          walletName.isAcceptableOrUnknown(
              data['wallet_name']!, _walletNameMeta));
    }
    if (data.containsKey('wallet_name_other')) {
      context.handle(
          _walletNameOtherMeta,
          walletNameOther.isAcceptableOrUnknown(
              data['wallet_name_other']!, _walletNameOtherMeta));
    }
    if (data.containsKey('measurement_type')) {
      context.handle(
          _measurementTypeMeta,
          measurementType.isAcceptableOrUnknown(
              data['measurement_type']!, _measurementTypeMeta));
    }
    if (data.containsKey('general_size')) {
      context.handle(
          _generalSizeMeta,
          generalSize.isAcceptableOrUnknown(
              data['general_size']!, _generalSizeMeta));
    }
    if (data.containsKey('measurement_notes')) {
      context.handle(
          _measurementNotesMeta,
          measurementNotes.isAcceptableOrUnknown(
              data['measurement_notes']!, _measurementNotesMeta));
    }
    if (data.containsKey('length')) {
      context.handle(_lengthMeta,
          length.isAcceptableOrUnknown(data['length']!, _lengthMeta));
    }
    if (data.containsKey('shoulder')) {
      context.handle(_shoulderMeta,
          shoulder.isAcceptableOrUnknown(data['shoulder']!, _shoulderMeta));
    }
    if (data.containsKey('sleeve')) {
      context.handle(_sleeveMeta,
          sleeve.isAcceptableOrUnknown(data['sleeve']!, _sleeveMeta));
    }
    if (data.containsKey('chest')) {
      context.handle(
          _chestMeta, chest.isAcceptableOrUnknown(data['chest']!, _chestMeta));
    }
    if (data.containsKey('waist')) {
      context.handle(
          _waistMeta, waist.isAcceptableOrUnknown(data['waist']!, _waistMeta));
    }
    if (data.containsKey('is_archived')) {
      context.handle(
          _isArchivedMeta,
          isArchived.isAcceptableOrUnknown(
              data['is_archived']!, _isArchivedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Order map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Order(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      orderNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_number'])!,
      orderDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}order_date'])!,
      deliveryDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}delivery_date']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      totalPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_price'])!,
      initialPayment: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}initial_payment'])!,
      initialPaymentMethod: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}initial_payment_method'])!,
      clientName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_name'])!,
      clientPhone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_phone'])!,
      clientAddress: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_address']),
      abayaType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}abaya_type'])!,
      abayaNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}abaya_number']),
      orderNotes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_notes']),
      orderSource: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_source'])!,
      orderSourceOther: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}order_source_other']),
      walletName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}wallet_name']),
      walletNameOther: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}wallet_name_other']),
      measurementType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}measurement_type'])!,
      generalSize: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}general_size']),
      measurementNotes: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}measurement_notes']),
      length: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}length']),
      shoulder: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}shoulder']),
      sleeve: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}sleeve']),
      chest: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}chest']),
      waist: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}waist']),
      isArchived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_archived'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }
}

class Order extends DataClass implements Insertable<Order> {
  final int id;
  final String orderNumber;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final String status;
  final double totalPrice;
  final double initialPayment;
  final String initialPaymentMethod;
  final String clientName;
  final String clientPhone;
  final String? clientAddress;
  final String abayaType;
  final String? abayaNumber;
  final String? orderNotes;
  final String orderSource;
  final String? orderSourceOther;
  final String? walletName;
  final String? walletNameOther;
  final String measurementType;
  final String? generalSize;
  final String? measurementNotes;
  final double? length;
  final double? shoulder;
  final double? sleeve;
  final double? chest;
  final double? waist;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Order(
      {required this.id,
      required this.orderNumber,
      required this.orderDate,
      this.deliveryDate,
      required this.status,
      required this.totalPrice,
      required this.initialPayment,
      required this.initialPaymentMethod,
      required this.clientName,
      required this.clientPhone,
      this.clientAddress,
      required this.abayaType,
      this.abayaNumber,
      this.orderNotes,
      required this.orderSource,
      this.orderSourceOther,
      this.walletName,
      this.walletNameOther,
      required this.measurementType,
      this.generalSize,
      this.measurementNotes,
      this.length,
      this.shoulder,
      this.sleeve,
      this.chest,
      this.waist,
      required this.isArchived,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_number'] = Variable<String>(orderNumber);
    map['order_date'] = Variable<DateTime>(orderDate);
    if (!nullToAbsent || deliveryDate != null) {
      map['delivery_date'] = Variable<DateTime>(deliveryDate);
    }
    map['status'] = Variable<String>(status);
    map['total_price'] = Variable<double>(totalPrice);
    map['initial_payment'] = Variable<double>(initialPayment);
    map['initial_payment_method'] = Variable<String>(initialPaymentMethod);
    map['client_name'] = Variable<String>(clientName);
    map['client_phone'] = Variable<String>(clientPhone);
    if (!nullToAbsent || clientAddress != null) {
      map['client_address'] = Variable<String>(clientAddress);
    }
    map['abaya_type'] = Variable<String>(abayaType);
    if (!nullToAbsent || abayaNumber != null) {
      map['abaya_number'] = Variable<String>(abayaNumber);
    }
    if (!nullToAbsent || orderNotes != null) {
      map['order_notes'] = Variable<String>(orderNotes);
    }
    map['order_source'] = Variable<String>(orderSource);
    if (!nullToAbsent || orderSourceOther != null) {
      map['order_source_other'] = Variable<String>(orderSourceOther);
    }
    if (!nullToAbsent || walletName != null) {
      map['wallet_name'] = Variable<String>(walletName);
    }
    if (!nullToAbsent || walletNameOther != null) {
      map['wallet_name_other'] = Variable<String>(walletNameOther);
    }
    map['measurement_type'] = Variable<String>(measurementType);
    if (!nullToAbsent || generalSize != null) {
      map['general_size'] = Variable<String>(generalSize);
    }
    if (!nullToAbsent || measurementNotes != null) {
      map['measurement_notes'] = Variable<String>(measurementNotes);
    }
    if (!nullToAbsent || length != null) {
      map['length'] = Variable<double>(length);
    }
    if (!nullToAbsent || shoulder != null) {
      map['shoulder'] = Variable<double>(shoulder);
    }
    if (!nullToAbsent || sleeve != null) {
      map['sleeve'] = Variable<double>(sleeve);
    }
    if (!nullToAbsent || chest != null) {
      map['chest'] = Variable<double>(chest);
    }
    if (!nullToAbsent || waist != null) {
      map['waist'] = Variable<double>(waist);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      orderNumber: Value(orderNumber),
      orderDate: Value(orderDate),
      deliveryDate: deliveryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveryDate),
      status: Value(status),
      totalPrice: Value(totalPrice),
      initialPayment: Value(initialPayment),
      initialPaymentMethod: Value(initialPaymentMethod),
      clientName: Value(clientName),
      clientPhone: Value(clientPhone),
      clientAddress: clientAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(clientAddress),
      abayaType: Value(abayaType),
      abayaNumber: abayaNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(abayaNumber),
      orderNotes: orderNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(orderNotes),
      orderSource: Value(orderSource),
      orderSourceOther: orderSourceOther == null && nullToAbsent
          ? const Value.absent()
          : Value(orderSourceOther),
      walletName: walletName == null && nullToAbsent
          ? const Value.absent()
          : Value(walletName),
      walletNameOther: walletNameOther == null && nullToAbsent
          ? const Value.absent()
          : Value(walletNameOther),
      measurementType: Value(measurementType),
      generalSize: generalSize == null && nullToAbsent
          ? const Value.absent()
          : Value(generalSize),
      measurementNotes: measurementNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(measurementNotes),
      length:
          length == null && nullToAbsent ? const Value.absent() : Value(length),
      shoulder: shoulder == null && nullToAbsent
          ? const Value.absent()
          : Value(shoulder),
      sleeve:
          sleeve == null && nullToAbsent ? const Value.absent() : Value(sleeve),
      chest:
          chest == null && nullToAbsent ? const Value.absent() : Value(chest),
      waist:
          waist == null && nullToAbsent ? const Value.absent() : Value(waist),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Order.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Order(
      id: serializer.fromJson<int>(json['id']),
      orderNumber: serializer.fromJson<String>(json['orderNumber']),
      orderDate: serializer.fromJson<DateTime>(json['orderDate']),
      deliveryDate: serializer.fromJson<DateTime?>(json['deliveryDate']),
      status: serializer.fromJson<String>(json['status']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      initialPayment: serializer.fromJson<double>(json['initialPayment']),
      initialPaymentMethod:
          serializer.fromJson<String>(json['initialPaymentMethod']),
      clientName: serializer.fromJson<String>(json['clientName']),
      clientPhone: serializer.fromJson<String>(json['clientPhone']),
      clientAddress: serializer.fromJson<String?>(json['clientAddress']),
      abayaType: serializer.fromJson<String>(json['abayaType']),
      abayaNumber: serializer.fromJson<String?>(json['abayaNumber']),
      orderNotes: serializer.fromJson<String?>(json['orderNotes']),
      orderSource: serializer.fromJson<String>(json['orderSource']),
      orderSourceOther: serializer.fromJson<String?>(json['orderSourceOther']),
      walletName: serializer.fromJson<String?>(json['walletName']),
      walletNameOther: serializer.fromJson<String?>(json['walletNameOther']),
      measurementType: serializer.fromJson<String>(json['measurementType']),
      generalSize: serializer.fromJson<String?>(json['generalSize']),
      measurementNotes: serializer.fromJson<String?>(json['measurementNotes']),
      length: serializer.fromJson<double?>(json['length']),
      shoulder: serializer.fromJson<double?>(json['shoulder']),
      sleeve: serializer.fromJson<double?>(json['sleeve']),
      chest: serializer.fromJson<double?>(json['chest']),
      waist: serializer.fromJson<double?>(json['waist']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderNumber': serializer.toJson<String>(orderNumber),
      'orderDate': serializer.toJson<DateTime>(orderDate),
      'deliveryDate': serializer.toJson<DateTime?>(deliveryDate),
      'status': serializer.toJson<String>(status),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'initialPayment': serializer.toJson<double>(initialPayment),
      'initialPaymentMethod': serializer.toJson<String>(initialPaymentMethod),
      'clientName': serializer.toJson<String>(clientName),
      'clientPhone': serializer.toJson<String>(clientPhone),
      'clientAddress': serializer.toJson<String?>(clientAddress),
      'abayaType': serializer.toJson<String>(abayaType),
      'abayaNumber': serializer.toJson<String?>(abayaNumber),
      'orderNotes': serializer.toJson<String?>(orderNotes),
      'orderSource': serializer.toJson<String>(orderSource),
      'orderSourceOther': serializer.toJson<String?>(orderSourceOther),
      'walletName': serializer.toJson<String?>(walletName),
      'walletNameOther': serializer.toJson<String?>(walletNameOther),
      'measurementType': serializer.toJson<String>(measurementType),
      'generalSize': serializer.toJson<String?>(generalSize),
      'measurementNotes': serializer.toJson<String?>(measurementNotes),
      'length': serializer.toJson<double?>(length),
      'shoulder': serializer.toJson<double?>(shoulder),
      'sleeve': serializer.toJson<double?>(sleeve),
      'chest': serializer.toJson<double?>(chest),
      'waist': serializer.toJson<double?>(waist),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Order copyWith(
          {int? id,
          String? orderNumber,
          DateTime? orderDate,
          Value<DateTime?> deliveryDate = const Value.absent(),
          String? status,
          double? totalPrice,
          double? initialPayment,
          String? initialPaymentMethod,
          String? clientName,
          String? clientPhone,
          Value<String?> clientAddress = const Value.absent(),
          String? abayaType,
          Value<String?> abayaNumber = const Value.absent(),
          Value<String?> orderNotes = const Value.absent(),
          String? orderSource,
          Value<String?> orderSourceOther = const Value.absent(),
          Value<String?> walletName = const Value.absent(),
          Value<String?> walletNameOther = const Value.absent(),
          String? measurementType,
          Value<String?> generalSize = const Value.absent(),
          Value<String?> measurementNotes = const Value.absent(),
          Value<double?> length = const Value.absent(),
          Value<double?> shoulder = const Value.absent(),
          Value<double?> sleeve = const Value.absent(),
          Value<double?> chest = const Value.absent(),
          Value<double?> waist = const Value.absent(),
          bool? isArchived,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Order(
        id: id ?? this.id,
        orderNumber: orderNumber ?? this.orderNumber,
        orderDate: orderDate ?? this.orderDate,
        deliveryDate:
            deliveryDate.present ? deliveryDate.value : this.deliveryDate,
        status: status ?? this.status,
        totalPrice: totalPrice ?? this.totalPrice,
        initialPayment: initialPayment ?? this.initialPayment,
        initialPaymentMethod: initialPaymentMethod ?? this.initialPaymentMethod,
        clientName: clientName ?? this.clientName,
        clientPhone: clientPhone ?? this.clientPhone,
        clientAddress:
            clientAddress.present ? clientAddress.value : this.clientAddress,
        abayaType: abayaType ?? this.abayaType,
        abayaNumber: abayaNumber.present ? abayaNumber.value : this.abayaNumber,
        orderNotes: orderNotes.present ? orderNotes.value : this.orderNotes,
        orderSource: orderSource ?? this.orderSource,
        orderSourceOther: orderSourceOther.present
            ? orderSourceOther.value
            : this.orderSourceOther,
        walletName: walletName.present ? walletName.value : this.walletName,
        walletNameOther: walletNameOther.present
            ? walletNameOther.value
            : this.walletNameOther,
        measurementType: measurementType ?? this.measurementType,
        generalSize: generalSize.present ? generalSize.value : this.generalSize,
        measurementNotes: measurementNotes.present
            ? measurementNotes.value
            : this.measurementNotes,
        length: length.present ? length.value : this.length,
        shoulder: shoulder.present ? shoulder.value : this.shoulder,
        sleeve: sleeve.present ? sleeve.value : this.sleeve,
        chest: chest.present ? chest.value : this.chest,
        waist: waist.present ? waist.value : this.waist,
        isArchived: isArchived ?? this.isArchived,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Order copyWithCompanion(OrdersCompanion data) {
    return Order(
      id: data.id.present ? data.id.value : this.id,
      orderNumber:
          data.orderNumber.present ? data.orderNumber.value : this.orderNumber,
      orderDate: data.orderDate.present ? data.orderDate.value : this.orderDate,
      deliveryDate: data.deliveryDate.present
          ? data.deliveryDate.value
          : this.deliveryDate,
      status: data.status.present ? data.status.value : this.status,
      totalPrice:
          data.totalPrice.present ? data.totalPrice.value : this.totalPrice,
      initialPayment: data.initialPayment.present
          ? data.initialPayment.value
          : this.initialPayment,
      initialPaymentMethod: data.initialPaymentMethod.present
          ? data.initialPaymentMethod.value
          : this.initialPaymentMethod,
      clientName:
          data.clientName.present ? data.clientName.value : this.clientName,
      clientPhone:
          data.clientPhone.present ? data.clientPhone.value : this.clientPhone,
      clientAddress: data.clientAddress.present
          ? data.clientAddress.value
          : this.clientAddress,
      abayaType: data.abayaType.present ? data.abayaType.value : this.abayaType,
      abayaNumber:
          data.abayaNumber.present ? data.abayaNumber.value : this.abayaNumber,
      orderNotes:
          data.orderNotes.present ? data.orderNotes.value : this.orderNotes,
      orderSource:
          data.orderSource.present ? data.orderSource.value : this.orderSource,
      orderSourceOther: data.orderSourceOther.present
          ? data.orderSourceOther.value
          : this.orderSourceOther,
      walletName:
          data.walletName.present ? data.walletName.value : this.walletName,
      walletNameOther: data.walletNameOther.present
          ? data.walletNameOther.value
          : this.walletNameOther,
      measurementType: data.measurementType.present
          ? data.measurementType.value
          : this.measurementType,
      generalSize:
          data.generalSize.present ? data.generalSize.value : this.generalSize,
      measurementNotes: data.measurementNotes.present
          ? data.measurementNotes.value
          : this.measurementNotes,
      length: data.length.present ? data.length.value : this.length,
      shoulder: data.shoulder.present ? data.shoulder.value : this.shoulder,
      sleeve: data.sleeve.present ? data.sleeve.value : this.sleeve,
      chest: data.chest.present ? data.chest.value : this.chest,
      waist: data.waist.present ? data.waist.value : this.waist,
      isArchived:
          data.isArchived.present ? data.isArchived.value : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Order(')
          ..write('id: $id, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('orderDate: $orderDate, ')
          ..write('deliveryDate: $deliveryDate, ')
          ..write('status: $status, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('initialPayment: $initialPayment, ')
          ..write('initialPaymentMethod: $initialPaymentMethod, ')
          ..write('clientName: $clientName, ')
          ..write('clientPhone: $clientPhone, ')
          ..write('clientAddress: $clientAddress, ')
          ..write('abayaType: $abayaType, ')
          ..write('abayaNumber: $abayaNumber, ')
          ..write('orderNotes: $orderNotes, ')
          ..write('orderSource: $orderSource, ')
          ..write('orderSourceOther: $orderSourceOther, ')
          ..write('walletName: $walletName, ')
          ..write('walletNameOther: $walletNameOther, ')
          ..write('measurementType: $measurementType, ')
          ..write('generalSize: $generalSize, ')
          ..write('measurementNotes: $measurementNotes, ')
          ..write('length: $length, ')
          ..write('shoulder: $shoulder, ')
          ..write('sleeve: $sleeve, ')
          ..write('chest: $chest, ')
          ..write('waist: $waist, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        orderNumber,
        orderDate,
        deliveryDate,
        status,
        totalPrice,
        initialPayment,
        initialPaymentMethod,
        clientName,
        clientPhone,
        clientAddress,
        abayaType,
        abayaNumber,
        orderNotes,
        orderSource,
        orderSourceOther,
        walletName,
        walletNameOther,
        measurementType,
        generalSize,
        measurementNotes,
        length,
        shoulder,
        sleeve,
        chest,
        waist,
        isArchived,
        createdAt,
        updatedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          other.id == this.id &&
          other.orderNumber == this.orderNumber &&
          other.orderDate == this.orderDate &&
          other.deliveryDate == this.deliveryDate &&
          other.status == this.status &&
          other.totalPrice == this.totalPrice &&
          other.initialPayment == this.initialPayment &&
          other.initialPaymentMethod == this.initialPaymentMethod &&
          other.clientName == this.clientName &&
          other.clientPhone == this.clientPhone &&
          other.clientAddress == this.clientAddress &&
          other.abayaType == this.abayaType &&
          other.abayaNumber == this.abayaNumber &&
          other.orderNotes == this.orderNotes &&
          other.orderSource == this.orderSource &&
          other.orderSourceOther == this.orderSourceOther &&
          other.walletName == this.walletName &&
          other.walletNameOther == this.walletNameOther &&
          other.measurementType == this.measurementType &&
          other.generalSize == this.generalSize &&
          other.measurementNotes == this.measurementNotes &&
          other.length == this.length &&
          other.shoulder == this.shoulder &&
          other.sleeve == this.sleeve &&
          other.chest == this.chest &&
          other.waist == this.waist &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class OrdersCompanion extends UpdateCompanion<Order> {
  final Value<int> id;
  final Value<String> orderNumber;
  final Value<DateTime> orderDate;
  final Value<DateTime?> deliveryDate;
  final Value<String> status;
  final Value<double> totalPrice;
  final Value<double> initialPayment;
  final Value<String> initialPaymentMethod;
  final Value<String> clientName;
  final Value<String> clientPhone;
  final Value<String?> clientAddress;
  final Value<String> abayaType;
  final Value<String?> abayaNumber;
  final Value<String?> orderNotes;
  final Value<String> orderSource;
  final Value<String?> orderSourceOther;
  final Value<String?> walletName;
  final Value<String?> walletNameOther;
  final Value<String> measurementType;
  final Value<String?> generalSize;
  final Value<String?> measurementNotes;
  final Value<double?> length;
  final Value<double?> shoulder;
  final Value<double?> sleeve;
  final Value<double?> chest;
  final Value<double?> waist;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.orderNumber = const Value.absent(),
    this.orderDate = const Value.absent(),
    this.deliveryDate = const Value.absent(),
    this.status = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.initialPayment = const Value.absent(),
    this.initialPaymentMethod = const Value.absent(),
    this.clientName = const Value.absent(),
    this.clientPhone = const Value.absent(),
    this.clientAddress = const Value.absent(),
    this.abayaType = const Value.absent(),
    this.abayaNumber = const Value.absent(),
    this.orderNotes = const Value.absent(),
    this.orderSource = const Value.absent(),
    this.orderSourceOther = const Value.absent(),
    this.walletName = const Value.absent(),
    this.walletNameOther = const Value.absent(),
    this.measurementType = const Value.absent(),
    this.generalSize = const Value.absent(),
    this.measurementNotes = const Value.absent(),
    this.length = const Value.absent(),
    this.shoulder = const Value.absent(),
    this.sleeve = const Value.absent(),
    this.chest = const Value.absent(),
    this.waist = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  OrdersCompanion.insert({
    this.id = const Value.absent(),
    required String orderNumber,
    required DateTime orderDate,
    this.deliveryDate = const Value.absent(),
    this.status = const Value.absent(),
    required double totalPrice,
    this.initialPayment = const Value.absent(),
    this.initialPaymentMethod = const Value.absent(),
    required String clientName,
    required String clientPhone,
    this.clientAddress = const Value.absent(),
    required String abayaType,
    this.abayaNumber = const Value.absent(),
    this.orderNotes = const Value.absent(),
    this.orderSource = const Value.absent(),
    this.orderSourceOther = const Value.absent(),
    this.walletName = const Value.absent(),
    this.walletNameOther = const Value.absent(),
    this.measurementType = const Value.absent(),
    this.generalSize = const Value.absent(),
    this.measurementNotes = const Value.absent(),
    this.length = const Value.absent(),
    this.shoulder = const Value.absent(),
    this.sleeve = const Value.absent(),
    this.chest = const Value.absent(),
    this.waist = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : orderNumber = Value(orderNumber),
        orderDate = Value(orderDate),
        totalPrice = Value(totalPrice),
        clientName = Value(clientName),
        clientPhone = Value(clientPhone),
        abayaType = Value(abayaType);
  static Insertable<Order> custom({
    Expression<int>? id,
    Expression<String>? orderNumber,
    Expression<DateTime>? orderDate,
    Expression<DateTime>? deliveryDate,
    Expression<String>? status,
    Expression<double>? totalPrice,
    Expression<double>? initialPayment,
    Expression<String>? initialPaymentMethod,
    Expression<String>? clientName,
    Expression<String>? clientPhone,
    Expression<String>? clientAddress,
    Expression<String>? abayaType,
    Expression<String>? abayaNumber,
    Expression<String>? orderNotes,
    Expression<String>? orderSource,
    Expression<String>? orderSourceOther,
    Expression<String>? walletName,
    Expression<String>? walletNameOther,
    Expression<String>? measurementType,
    Expression<String>? generalSize,
    Expression<String>? measurementNotes,
    Expression<double>? length,
    Expression<double>? shoulder,
    Expression<double>? sleeve,
    Expression<double>? chest,
    Expression<double>? waist,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderNumber != null) 'order_number': orderNumber,
      if (orderDate != null) 'order_date': orderDate,
      if (deliveryDate != null) 'delivery_date': deliveryDate,
      if (status != null) 'status': status,
      if (totalPrice != null) 'total_price': totalPrice,
      if (initialPayment != null) 'initial_payment': initialPayment,
      if (initialPaymentMethod != null)
        'initial_payment_method': initialPaymentMethod,
      if (clientName != null) 'client_name': clientName,
      if (clientPhone != null) 'client_phone': clientPhone,
      if (clientAddress != null) 'client_address': clientAddress,
      if (abayaType != null) 'abaya_type': abayaType,
      if (abayaNumber != null) 'abaya_number': abayaNumber,
      if (orderNotes != null) 'order_notes': orderNotes,
      if (orderSource != null) 'order_source': orderSource,
      if (orderSourceOther != null) 'order_source_other': orderSourceOther,
      if (walletName != null) 'wallet_name': walletName,
      if (walletNameOther != null) 'wallet_name_other': walletNameOther,
      if (measurementType != null) 'measurement_type': measurementType,
      if (generalSize != null) 'general_size': generalSize,
      if (measurementNotes != null) 'measurement_notes': measurementNotes,
      if (length != null) 'length': length,
      if (shoulder != null) 'shoulder': shoulder,
      if (sleeve != null) 'sleeve': sleeve,
      if (chest != null) 'chest': chest,
      if (waist != null) 'waist': waist,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  OrdersCompanion copyWith(
      {Value<int>? id,
      Value<String>? orderNumber,
      Value<DateTime>? orderDate,
      Value<DateTime?>? deliveryDate,
      Value<String>? status,
      Value<double>? totalPrice,
      Value<double>? initialPayment,
      Value<String>? initialPaymentMethod,
      Value<String>? clientName,
      Value<String>? clientPhone,
      Value<String?>? clientAddress,
      Value<String>? abayaType,
      Value<String?>? abayaNumber,
      Value<String?>? orderNotes,
      Value<String>? orderSource,
      Value<String?>? orderSourceOther,
      Value<String?>? walletName,
      Value<String?>? walletNameOther,
      Value<String>? measurementType,
      Value<String?>? generalSize,
      Value<String?>? measurementNotes,
      Value<double?>? length,
      Value<double?>? shoulder,
      Value<double?>? sleeve,
      Value<double?>? chest,
      Value<double?>? waist,
      Value<bool>? isArchived,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return OrdersCompanion(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      orderDate: orderDate ?? this.orderDate,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
      initialPayment: initialPayment ?? this.initialPayment,
      initialPaymentMethod: initialPaymentMethod ?? this.initialPaymentMethod,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      clientAddress: clientAddress ?? this.clientAddress,
      abayaType: abayaType ?? this.abayaType,
      abayaNumber: abayaNumber ?? this.abayaNumber,
      orderNotes: orderNotes ?? this.orderNotes,
      orderSource: orderSource ?? this.orderSource,
      orderSourceOther: orderSourceOther ?? this.orderSourceOther,
      walletName: walletName ?? this.walletName,
      walletNameOther: walletNameOther ?? this.walletNameOther,
      measurementType: measurementType ?? this.measurementType,
      generalSize: generalSize ?? this.generalSize,
      measurementNotes: measurementNotes ?? this.measurementNotes,
      length: length ?? this.length,
      shoulder: shoulder ?? this.shoulder,
      sleeve: sleeve ?? this.sleeve,
      chest: chest ?? this.chest,
      waist: waist ?? this.waist,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderNumber.present) {
      map['order_number'] = Variable<String>(orderNumber.value);
    }
    if (orderDate.present) {
      map['order_date'] = Variable<DateTime>(orderDate.value);
    }
    if (deliveryDate.present) {
      map['delivery_date'] = Variable<DateTime>(deliveryDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (initialPayment.present) {
      map['initial_payment'] = Variable<double>(initialPayment.value);
    }
    if (initialPaymentMethod.present) {
      map['initial_payment_method'] =
          Variable<String>(initialPaymentMethod.value);
    }
    if (clientName.present) {
      map['client_name'] = Variable<String>(clientName.value);
    }
    if (clientPhone.present) {
      map['client_phone'] = Variable<String>(clientPhone.value);
    }
    if (clientAddress.present) {
      map['client_address'] = Variable<String>(clientAddress.value);
    }
    if (abayaType.present) {
      map['abaya_type'] = Variable<String>(abayaType.value);
    }
    if (abayaNumber.present) {
      map['abaya_number'] = Variable<String>(abayaNumber.value);
    }
    if (orderNotes.present) {
      map['order_notes'] = Variable<String>(orderNotes.value);
    }
    if (orderSource.present) {
      map['order_source'] = Variable<String>(orderSource.value);
    }
    if (orderSourceOther.present) {
      map['order_source_other'] = Variable<String>(orderSourceOther.value);
    }
    if (walletName.present) {
      map['wallet_name'] = Variable<String>(walletName.value);
    }
    if (walletNameOther.present) {
      map['wallet_name_other'] = Variable<String>(walletNameOther.value);
    }
    if (measurementType.present) {
      map['measurement_type'] = Variable<String>(measurementType.value);
    }
    if (generalSize.present) {
      map['general_size'] = Variable<String>(generalSize.value);
    }
    if (measurementNotes.present) {
      map['measurement_notes'] = Variable<String>(measurementNotes.value);
    }
    if (length.present) {
      map['length'] = Variable<double>(length.value);
    }
    if (shoulder.present) {
      map['shoulder'] = Variable<double>(shoulder.value);
    }
    if (sleeve.present) {
      map['sleeve'] = Variable<double>(sleeve.value);
    }
    if (chest.present) {
      map['chest'] = Variable<double>(chest.value);
    }
    if (waist.present) {
      map['waist'] = Variable<double>(waist.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('orderDate: $orderDate, ')
          ..write('deliveryDate: $deliveryDate, ')
          ..write('status: $status, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('initialPayment: $initialPayment, ')
          ..write('initialPaymentMethod: $initialPaymentMethod, ')
          ..write('clientName: $clientName, ')
          ..write('clientPhone: $clientPhone, ')
          ..write('clientAddress: $clientAddress, ')
          ..write('abayaType: $abayaType, ')
          ..write('abayaNumber: $abayaNumber, ')
          ..write('orderNotes: $orderNotes, ')
          ..write('orderSource: $orderSource, ')
          ..write('orderSourceOther: $orderSourceOther, ')
          ..write('walletName: $walletName, ')
          ..write('walletNameOther: $walletNameOther, ')
          ..write('measurementType: $measurementType, ')
          ..write('generalSize: $generalSize, ')
          ..write('measurementNotes: $measurementNotes, ')
          ..write('length: $length, ')
          ..write('shoulder: $shoulder, ')
          ..write('sleeve: $sleeve, ')
          ..write('chest: $chest, ')
          ..write('waist: $waist, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ReceiptsTable extends Receipts with TableInfo<$ReceiptsTable, Receipt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceiptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _receiptNumberMeta =
      const VerificationMeta('receiptNumber');
  @override
  late final GeneratedColumn<String> receiptNumber = GeneratedColumn<String>(
      'receipt_number', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _orderIdMeta =
      const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
      'order_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES orders (id) ON DELETE CASCADE'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _paymentMethodMeta =
      const VerificationMeta('paymentMethod');
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
      'payment_method', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('cash'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        receiptNumber,
        orderId,
        amount,
        date,
        paymentMethod,
        notes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'receipts';
  @override
  VerificationContext validateIntegrity(Insertable<Receipt> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('receipt_number')) {
      context.handle(
          _receiptNumberMeta,
          receiptNumber.isAcceptableOrUnknown(
              data['receipt_number']!, _receiptNumberMeta));
    } else if (isInserting) {
      context.missing(_receiptNumberMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _paymentMethodMeta,
          paymentMethod.isAcceptableOrUnknown(
              data['payment_method']!, _paymentMethodMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Receipt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Receipt(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      receiptNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}receipt_number'])!,
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      paymentMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_method'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ReceiptsTable createAlias(String alias) {
    return $ReceiptsTable(attachedDatabase, alias);
  }
}

class Receipt extends DataClass implements Insertable<Receipt> {
  final int id;
  final String receiptNumber;
  final int orderId;
  final double amount;
  final DateTime date;
  final String paymentMethod;
  final String? notes;
  final DateTime createdAt;
  const Receipt(
      {required this.id,
      required this.receiptNumber,
      required this.orderId,
      required this.amount,
      required this.date,
      required this.paymentMethod,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['receipt_number'] = Variable<String>(receiptNumber);
    map['order_id'] = Variable<int>(orderId);
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    map['payment_method'] = Variable<String>(paymentMethod);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ReceiptsCompanion toCompanion(bool nullToAbsent) {
    return ReceiptsCompanion(
      id: Value(id),
      receiptNumber: Value(receiptNumber),
      orderId: Value(orderId),
      amount: Value(amount),
      date: Value(date),
      paymentMethod: Value(paymentMethod),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory Receipt.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Receipt(
      id: serializer.fromJson<int>(json['id']),
      receiptNumber: serializer.fromJson<String>(json['receiptNumber']),
      orderId: serializer.fromJson<int>(json['orderId']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'receiptNumber': serializer.toJson<String>(receiptNumber),
      'orderId': serializer.toJson<int>(orderId),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Receipt copyWith(
          {int? id,
          String? receiptNumber,
          int? orderId,
          double? amount,
          DateTime? date,
          String? paymentMethod,
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      Receipt(
        id: id ?? this.id,
        receiptNumber: receiptNumber ?? this.receiptNumber,
        orderId: orderId ?? this.orderId,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  Receipt copyWithCompanion(ReceiptsCompanion data) {
    return Receipt(
      id: data.id.present ? data.id.value : this.id,
      receiptNumber: data.receiptNumber.present
          ? data.receiptNumber.value
          : this.receiptNumber,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Receipt(')
          ..write('id: $id, ')
          ..write('receiptNumber: $receiptNumber, ')
          ..write('orderId: $orderId, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, receiptNumber, orderId, amount, date,
      paymentMethod, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Receipt &&
          other.id == this.id &&
          other.receiptNumber == this.receiptNumber &&
          other.orderId == this.orderId &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.paymentMethod == this.paymentMethod &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class ReceiptsCompanion extends UpdateCompanion<Receipt> {
  final Value<int> id;
  final Value<String> receiptNumber;
  final Value<int> orderId;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<String> paymentMethod;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const ReceiptsCompanion({
    this.id = const Value.absent(),
    this.receiptNumber = const Value.absent(),
    this.orderId = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ReceiptsCompanion.insert({
    this.id = const Value.absent(),
    required String receiptNumber,
    required int orderId,
    required double amount,
    required DateTime date,
    this.paymentMethod = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : receiptNumber = Value(receiptNumber),
        orderId = Value(orderId),
        amount = Value(amount),
        date = Value(date);
  static Insertable<Receipt> custom({
    Expression<int>? id,
    Expression<String>? receiptNumber,
    Expression<int>? orderId,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<String>? paymentMethod,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (receiptNumber != null) 'receipt_number': receiptNumber,
      if (orderId != null) 'order_id': orderId,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ReceiptsCompanion copyWith(
      {Value<int>? id,
      Value<String>? receiptNumber,
      Value<int>? orderId,
      Value<double>? amount,
      Value<DateTime>? date,
      Value<String>? paymentMethod,
      Value<String?>? notes,
      Value<DateTime>? createdAt}) {
    return ReceiptsCompanion(
      id: id ?? this.id,
      receiptNumber: receiptNumber ?? this.receiptNumber,
      orderId: orderId ?? this.orderId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (receiptNumber.present) {
      map['receipt_number'] = Variable<String>(receiptNumber.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptsCompanion(')
          ..write('id: $id, ')
          ..write('receiptNumber: $receiptNumber, ')
          ..write('orderId: $orderId, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $NotificationsTable extends Notifications
    with TableInfo<$NotificationsTable, Notification> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderIdMeta =
      const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
      'order_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _orderNumberMeta =
      const VerificationMeta('orderNumber');
  @override
  late final GeneratedColumn<String> orderNumber = GeneratedColumn<String>(
      'order_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _scheduledAtMeta =
      const VerificationMeta('scheduledAt');
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
      'scheduled_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
      'is_read', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_read" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isDeliveredMeta =
      const VerificationMeta('isDelivered');
  @override
  late final GeneratedColumn<bool> isDelivered = GeneratedColumn<bool>(
      'is_delivered', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_delivered" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        body,
        type,
        orderId,
        orderNumber,
        scheduledAt,
        createdAt,
        isRead,
        isDelivered
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notifications';
  @override
  VerificationContext validateIntegrity(Insertable<Notification> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    }
    if (data.containsKey('order_number')) {
      context.handle(
          _orderNumberMeta,
          orderNumber.isAcceptableOrUnknown(
              data['order_number']!, _orderNumberMeta));
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
          _scheduledAtMeta,
          scheduledAt.isAcceptableOrUnknown(
              data['scheduled_at']!, _scheduledAtMeta));
    } else if (isInserting) {
      context.missing(_scheduledAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('is_read')) {
      context.handle(_isReadMeta,
          isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta));
    }
    if (data.containsKey('is_delivered')) {
      context.handle(
          _isDeliveredMeta,
          isDelivered.isAcceptableOrUnknown(
              data['is_delivered']!, _isDeliveredMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Notification map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Notification(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      body: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_id']),
      orderNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_number']),
      scheduledAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}scheduled_at'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      isRead: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_read'])!,
      isDelivered: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_delivered'])!,
    );
  }

  @override
  $NotificationsTable createAlias(String alias) {
    return $NotificationsTable(attachedDatabase, alias);
  }
}

class Notification extends DataClass implements Insertable<Notification> {
  final int id;
  final String title;
  final String body;
  final String type;
  final int? orderId;
  final String? orderNumber;
  final DateTime scheduledAt;
  final DateTime createdAt;
  final bool isRead;
  final bool isDelivered;
  const Notification(
      {required this.id,
      required this.title,
      required this.body,
      required this.type,
      this.orderId,
      this.orderNumber,
      required this.scheduledAt,
      required this.createdAt,
      required this.isRead,
      required this.isDelivered});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || orderId != null) {
      map['order_id'] = Variable<int>(orderId);
    }
    if (!nullToAbsent || orderNumber != null) {
      map['order_number'] = Variable<String>(orderNumber);
    }
    map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_read'] = Variable<bool>(isRead);
    map['is_delivered'] = Variable<bool>(isDelivered);
    return map;
  }

  NotificationsCompanion toCompanion(bool nullToAbsent) {
    return NotificationsCompanion(
      id: Value(id),
      title: Value(title),
      body: Value(body),
      type: Value(type),
      orderId: orderId == null && nullToAbsent
          ? const Value.absent()
          : Value(orderId),
      orderNumber: orderNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(orderNumber),
      scheduledAt: Value(scheduledAt),
      createdAt: Value(createdAt),
      isRead: Value(isRead),
      isDelivered: Value(isDelivered),
    );
  }

  factory Notification.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Notification(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      type: serializer.fromJson<String>(json['type']),
      orderId: serializer.fromJson<int?>(json['orderId']),
      orderNumber: serializer.fromJson<String?>(json['orderNumber']),
      scheduledAt: serializer.fromJson<DateTime>(json['scheduledAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      isDelivered: serializer.fromJson<bool>(json['isDelivered']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'type': serializer.toJson<String>(type),
      'orderId': serializer.toJson<int?>(orderId),
      'orderNumber': serializer.toJson<String?>(orderNumber),
      'scheduledAt': serializer.toJson<DateTime>(scheduledAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isRead': serializer.toJson<bool>(isRead),
      'isDelivered': serializer.toJson<bool>(isDelivered),
    };
  }

  Notification copyWith(
          {int? id,
          String? title,
          String? body,
          String? type,
          Value<int?> orderId = const Value.absent(),
          Value<String?> orderNumber = const Value.absent(),
          DateTime? scheduledAt,
          DateTime? createdAt,
          bool? isRead,
          bool? isDelivered}) =>
      Notification(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        type: type ?? this.type,
        orderId: orderId.present ? orderId.value : this.orderId,
        orderNumber: orderNumber.present ? orderNumber.value : this.orderNumber,
        scheduledAt: scheduledAt ?? this.scheduledAt,
        createdAt: createdAt ?? this.createdAt,
        isRead: isRead ?? this.isRead,
        isDelivered: isDelivered ?? this.isDelivered,
      );
  Notification copyWithCompanion(NotificationsCompanion data) {
    return Notification(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      type: data.type.present ? data.type.value : this.type,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      orderNumber:
          data.orderNumber.present ? data.orderNumber.value : this.orderNumber,
      scheduledAt:
          data.scheduledAt.present ? data.scheduledAt.value : this.scheduledAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      isDelivered:
          data.isDelivered.present ? data.isDelivered.value : this.isDelivered,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Notification(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('type: $type, ')
          ..write('orderId: $orderId, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('isRead: $isRead, ')
          ..write('isDelivered: $isDelivered')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, body, type, orderId, orderNumber,
      scheduledAt, createdAt, isRead, isDelivered);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Notification &&
          other.id == this.id &&
          other.title == this.title &&
          other.body == this.body &&
          other.type == this.type &&
          other.orderId == this.orderId &&
          other.orderNumber == this.orderNumber &&
          other.scheduledAt == this.scheduledAt &&
          other.createdAt == this.createdAt &&
          other.isRead == this.isRead &&
          other.isDelivered == this.isDelivered);
}

class NotificationsCompanion extends UpdateCompanion<Notification> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> body;
  final Value<String> type;
  final Value<int?> orderId;
  final Value<String?> orderNumber;
  final Value<DateTime> scheduledAt;
  final Value<DateTime> createdAt;
  final Value<bool> isRead;
  final Value<bool> isDelivered;
  const NotificationsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.type = const Value.absent(),
    this.orderId = const Value.absent(),
    this.orderNumber = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isRead = const Value.absent(),
    this.isDelivered = const Value.absent(),
  });
  NotificationsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String body,
    required String type,
    this.orderId = const Value.absent(),
    this.orderNumber = const Value.absent(),
    required DateTime scheduledAt,
    this.createdAt = const Value.absent(),
    this.isRead = const Value.absent(),
    this.isDelivered = const Value.absent(),
  })  : title = Value(title),
        body = Value(body),
        type = Value(type),
        scheduledAt = Value(scheduledAt);
  static Insertable<Notification> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? type,
    Expression<int>? orderId,
    Expression<String>? orderNumber,
    Expression<DateTime>? scheduledAt,
    Expression<DateTime>? createdAt,
    Expression<bool>? isRead,
    Expression<bool>? isDelivered,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (type != null) 'type': type,
      if (orderId != null) 'order_id': orderId,
      if (orderNumber != null) 'order_number': orderNumber,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (createdAt != null) 'created_at': createdAt,
      if (isRead != null) 'is_read': isRead,
      if (isDelivered != null) 'is_delivered': isDelivered,
    });
  }

  NotificationsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? body,
      Value<String>? type,
      Value<int?>? orderId,
      Value<String?>? orderNumber,
      Value<DateTime>? scheduledAt,
      Value<DateTime>? createdAt,
      Value<bool>? isRead,
      Value<bool>? isDelivered}) {
    return NotificationsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      orderId: orderId ?? this.orderId,
      orderNumber: orderNumber ?? this.orderNumber,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      isDelivered: isDelivered ?? this.isDelivered,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (orderNumber.present) {
      map['order_number'] = Variable<String>(orderNumber.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (isDelivered.present) {
      map['is_delivered'] = Variable<bool>(isDelivered.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('type: $type, ')
          ..write('orderId: $orderId, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('isRead: $isRead, ')
          ..write('isDelivered: $isDelivered')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $ReceiptsTable receipts = $ReceiptsTable(this);
  late final $NotificationsTable notifications = $NotificationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [orders, receipts, notifications];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('orders',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('receipts', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$OrdersTableCreateCompanionBuilder = OrdersCompanion Function({
  Value<int> id,
  required String orderNumber,
  required DateTime orderDate,
  Value<DateTime?> deliveryDate,
  Value<String> status,
  required double totalPrice,
  Value<double> initialPayment,
  Value<String> initialPaymentMethod,
  required String clientName,
  required String clientPhone,
  Value<String?> clientAddress,
  required String abayaType,
  Value<String?> abayaNumber,
  Value<String?> orderNotes,
  Value<String> orderSource,
  Value<String?> orderSourceOther,
  Value<String?> walletName,
  Value<String?> walletNameOther,
  Value<String> measurementType,
  Value<String?> generalSize,
  Value<String?> measurementNotes,
  Value<double?> length,
  Value<double?> shoulder,
  Value<double?> sleeve,
  Value<double?> chest,
  Value<double?> waist,
  Value<bool> isArchived,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$OrdersTableUpdateCompanionBuilder = OrdersCompanion Function({
  Value<int> id,
  Value<String> orderNumber,
  Value<DateTime> orderDate,
  Value<DateTime?> deliveryDate,
  Value<String> status,
  Value<double> totalPrice,
  Value<double> initialPayment,
  Value<String> initialPaymentMethod,
  Value<String> clientName,
  Value<String> clientPhone,
  Value<String?> clientAddress,
  Value<String> abayaType,
  Value<String?> abayaNumber,
  Value<String?> orderNotes,
  Value<String> orderSource,
  Value<String?> orderSourceOther,
  Value<String?> walletName,
  Value<String?> walletNameOther,
  Value<String> measurementType,
  Value<String?> generalSize,
  Value<String?> measurementNotes,
  Value<double?> length,
  Value<double?> shoulder,
  Value<double?> sleeve,
  Value<double?> chest,
  Value<double?> waist,
  Value<bool> isArchived,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$OrdersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrdersTable,
    Order,
    $$OrdersTableFilterComposer,
    $$OrdersTableOrderingComposer,
    $$OrdersTableCreateCompanionBuilder,
    $$OrdersTableUpdateCompanionBuilder> {
  $$OrdersTableTableManager(_$AppDatabase db, $OrdersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$OrdersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$OrdersTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> orderNumber = const Value.absent(),
            Value<DateTime> orderDate = const Value.absent(),
            Value<DateTime?> deliveryDate = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<double> totalPrice = const Value.absent(),
            Value<double> initialPayment = const Value.absent(),
            Value<String> initialPaymentMethod = const Value.absent(),
            Value<String> clientName = const Value.absent(),
            Value<String> clientPhone = const Value.absent(),
            Value<String?> clientAddress = const Value.absent(),
            Value<String> abayaType = const Value.absent(),
            Value<String?> abayaNumber = const Value.absent(),
            Value<String?> orderNotes = const Value.absent(),
            Value<String> orderSource = const Value.absent(),
            Value<String?> orderSourceOther = const Value.absent(),
            Value<String?> walletName = const Value.absent(),
            Value<String?> walletNameOther = const Value.absent(),
            Value<String> measurementType = const Value.absent(),
            Value<String?> generalSize = const Value.absent(),
            Value<String?> measurementNotes = const Value.absent(),
            Value<double?> length = const Value.absent(),
            Value<double?> shoulder = const Value.absent(),
            Value<double?> sleeve = const Value.absent(),
            Value<double?> chest = const Value.absent(),
            Value<double?> waist = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              OrdersCompanion(
            id: id,
            orderNumber: orderNumber,
            orderDate: orderDate,
            deliveryDate: deliveryDate,
            status: status,
            totalPrice: totalPrice,
            initialPayment: initialPayment,
            initialPaymentMethod: initialPaymentMethod,
            clientName: clientName,
            clientPhone: clientPhone,
            clientAddress: clientAddress,
            abayaType: abayaType,
            abayaNumber: abayaNumber,
            orderNotes: orderNotes,
            orderSource: orderSource,
            orderSourceOther: orderSourceOther,
            walletName: walletName,
            walletNameOther: walletNameOther,
            measurementType: measurementType,
            generalSize: generalSize,
            measurementNotes: measurementNotes,
            length: length,
            shoulder: shoulder,
            sleeve: sleeve,
            chest: chest,
            waist: waist,
            isArchived: isArchived,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String orderNumber,
            required DateTime orderDate,
            Value<DateTime?> deliveryDate = const Value.absent(),
            Value<String> status = const Value.absent(),
            required double totalPrice,
            Value<double> initialPayment = const Value.absent(),
            Value<String> initialPaymentMethod = const Value.absent(),
            required String clientName,
            required String clientPhone,
            Value<String?> clientAddress = const Value.absent(),
            required String abayaType,
            Value<String?> abayaNumber = const Value.absent(),
            Value<String?> orderNotes = const Value.absent(),
            Value<String> orderSource = const Value.absent(),
            Value<String?> orderSourceOther = const Value.absent(),
            Value<String?> walletName = const Value.absent(),
            Value<String?> walletNameOther = const Value.absent(),
            Value<String> measurementType = const Value.absent(),
            Value<String?> generalSize = const Value.absent(),
            Value<String?> measurementNotes = const Value.absent(),
            Value<double?> length = const Value.absent(),
            Value<double?> shoulder = const Value.absent(),
            Value<double?> sleeve = const Value.absent(),
            Value<double?> chest = const Value.absent(),
            Value<double?> waist = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              OrdersCompanion.insert(
            id: id,
            orderNumber: orderNumber,
            orderDate: orderDate,
            deliveryDate: deliveryDate,
            status: status,
            totalPrice: totalPrice,
            initialPayment: initialPayment,
            initialPaymentMethod: initialPaymentMethod,
            clientName: clientName,
            clientPhone: clientPhone,
            clientAddress: clientAddress,
            abayaType: abayaType,
            abayaNumber: abayaNumber,
            orderNotes: orderNotes,
            orderSource: orderSource,
            orderSourceOther: orderSourceOther,
            walletName: walletName,
            walletNameOther: walletNameOther,
            measurementType: measurementType,
            generalSize: generalSize,
            measurementNotes: measurementNotes,
            length: length,
            shoulder: shoulder,
            sleeve: sleeve,
            chest: chest,
            waist: waist,
            isArchived: isArchived,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
        ));
}

class $$OrdersTableFilterComposer
    extends FilterComposer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get orderNumber => $state.composableBuilder(
      column: $state.table.orderNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get orderDate => $state.composableBuilder(
      column: $state.table.orderDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deliveryDate => $state.composableBuilder(
      column: $state.table.deliveryDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get totalPrice => $state.composableBuilder(
      column: $state.table.totalPrice,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get initialPayment => $state.composableBuilder(
      column: $state.table.initialPayment,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get initialPaymentMethod => $state.composableBuilder(
      column: $state.table.initialPaymentMethod,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get clientName => $state.composableBuilder(
      column: $state.table.clientName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get clientPhone => $state.composableBuilder(
      column: $state.table.clientPhone,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get clientAddress => $state.composableBuilder(
      column: $state.table.clientAddress,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get abayaType => $state.composableBuilder(
      column: $state.table.abayaType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get abayaNumber => $state.composableBuilder(
      column: $state.table.abayaNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get orderNotes => $state.composableBuilder(
      column: $state.table.orderNotes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get orderSource => $state.composableBuilder(
      column: $state.table.orderSource,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get orderSourceOther => $state.composableBuilder(
      column: $state.table.orderSourceOther,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get walletName => $state.composableBuilder(
      column: $state.table.walletName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get walletNameOther => $state.composableBuilder(
      column: $state.table.walletNameOther,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get measurementType => $state.composableBuilder(
      column: $state.table.measurementType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get generalSize => $state.composableBuilder(
      column: $state.table.generalSize,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get measurementNotes => $state.composableBuilder(
      column: $state.table.measurementNotes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get length => $state.composableBuilder(
      column: $state.table.length,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get shoulder => $state.composableBuilder(
      column: $state.table.shoulder,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get sleeve => $state.composableBuilder(
      column: $state.table.sleeve,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get chest => $state.composableBuilder(
      column: $state.table.chest,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get waist => $state.composableBuilder(
      column: $state.table.waist,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isArchived => $state.composableBuilder(
      column: $state.table.isArchived,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter receiptsRefs(
      ComposableFilter Function($$ReceiptsTableFilterComposer f) f) {
    final $$ReceiptsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.receipts,
        getReferencedColumn: (t) => t.orderId,
        builder: (joinBuilder, parentComposers) =>
            $$ReceiptsTableFilterComposer(ComposerState(
                $state.db, $state.db.receipts, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$OrdersTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get orderNumber => $state.composableBuilder(
      column: $state.table.orderNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get orderDate => $state.composableBuilder(
      column: $state.table.orderDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deliveryDate => $state.composableBuilder(
      column: $state.table.deliveryDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get totalPrice => $state.composableBuilder(
      column: $state.table.totalPrice,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get initialPayment => $state.composableBuilder(
      column: $state.table.initialPayment,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get initialPaymentMethod => $state.composableBuilder(
      column: $state.table.initialPaymentMethod,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get clientName => $state.composableBuilder(
      column: $state.table.clientName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get clientPhone => $state.composableBuilder(
      column: $state.table.clientPhone,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get clientAddress => $state.composableBuilder(
      column: $state.table.clientAddress,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get abayaType => $state.composableBuilder(
      column: $state.table.abayaType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get abayaNumber => $state.composableBuilder(
      column: $state.table.abayaNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get orderNotes => $state.composableBuilder(
      column: $state.table.orderNotes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get orderSource => $state.composableBuilder(
      column: $state.table.orderSource,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get orderSourceOther => $state.composableBuilder(
      column: $state.table.orderSourceOther,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get walletName => $state.composableBuilder(
      column: $state.table.walletName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get walletNameOther => $state.composableBuilder(
      column: $state.table.walletNameOther,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get measurementType => $state.composableBuilder(
      column: $state.table.measurementType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get generalSize => $state.composableBuilder(
      column: $state.table.generalSize,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get measurementNotes => $state.composableBuilder(
      column: $state.table.measurementNotes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get length => $state.composableBuilder(
      column: $state.table.length,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get shoulder => $state.composableBuilder(
      column: $state.table.shoulder,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get sleeve => $state.composableBuilder(
      column: $state.table.sleeve,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get chest => $state.composableBuilder(
      column: $state.table.chest,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get waist => $state.composableBuilder(
      column: $state.table.waist,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isArchived => $state.composableBuilder(
      column: $state.table.isArchived,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ReceiptsTableCreateCompanionBuilder = ReceiptsCompanion Function({
  Value<int> id,
  required String receiptNumber,
  required int orderId,
  required double amount,
  required DateTime date,
  Value<String> paymentMethod,
  Value<String?> notes,
  Value<DateTime> createdAt,
});
typedef $$ReceiptsTableUpdateCompanionBuilder = ReceiptsCompanion Function({
  Value<int> id,
  Value<String> receiptNumber,
  Value<int> orderId,
  Value<double> amount,
  Value<DateTime> date,
  Value<String> paymentMethod,
  Value<String?> notes,
  Value<DateTime> createdAt,
});

class $$ReceiptsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReceiptsTable,
    Receipt,
    $$ReceiptsTableFilterComposer,
    $$ReceiptsTableOrderingComposer,
    $$ReceiptsTableCreateCompanionBuilder,
    $$ReceiptsTableUpdateCompanionBuilder> {
  $$ReceiptsTableTableManager(_$AppDatabase db, $ReceiptsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ReceiptsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ReceiptsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> receiptNumber = const Value.absent(),
            Value<int> orderId = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> paymentMethod = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ReceiptsCompanion(
            id: id,
            receiptNumber: receiptNumber,
            orderId: orderId,
            amount: amount,
            date: date,
            paymentMethod: paymentMethod,
            notes: notes,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String receiptNumber,
            required int orderId,
            required double amount,
            required DateTime date,
            Value<String> paymentMethod = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ReceiptsCompanion.insert(
            id: id,
            receiptNumber: receiptNumber,
            orderId: orderId,
            amount: amount,
            date: date,
            paymentMethod: paymentMethod,
            notes: notes,
            createdAt: createdAt,
          ),
        ));
}

class $$ReceiptsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get receiptNumber => $state.composableBuilder(
      column: $state.table.receiptNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get paymentMethod => $state.composableBuilder(
      column: $state.table.paymentMethod,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$OrdersTableFilterComposer get orderId {
    final $$OrdersTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $state.db.orders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$OrdersTableFilterComposer(
            ComposerState(
                $state.db, $state.db.orders, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$ReceiptsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get receiptNumber => $state.composableBuilder(
      column: $state.table.receiptNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get paymentMethod => $state.composableBuilder(
      column: $state.table.paymentMethod,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$OrdersTableOrderingComposer get orderId {
    final $$OrdersTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $state.db.orders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$OrdersTableOrderingComposer(ComposerState(
                $state.db, $state.db.orders, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$NotificationsTableCreateCompanionBuilder = NotificationsCompanion
    Function({
  Value<int> id,
  required String title,
  required String body,
  required String type,
  Value<int?> orderId,
  Value<String?> orderNumber,
  required DateTime scheduledAt,
  Value<DateTime> createdAt,
  Value<bool> isRead,
  Value<bool> isDelivered,
});
typedef $$NotificationsTableUpdateCompanionBuilder = NotificationsCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<String> body,
  Value<String> type,
  Value<int?> orderId,
  Value<String?> orderNumber,
  Value<DateTime> scheduledAt,
  Value<DateTime> createdAt,
  Value<bool> isRead,
  Value<bool> isDelivered,
});

class $$NotificationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotificationsTable,
    Notification,
    $$NotificationsTableFilterComposer,
    $$NotificationsTableOrderingComposer,
    $$NotificationsTableCreateCompanionBuilder,
    $$NotificationsTableUpdateCompanionBuilder> {
  $$NotificationsTableTableManager(_$AppDatabase db, $NotificationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$NotificationsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$NotificationsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> body = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int?> orderId = const Value.absent(),
            Value<String?> orderNumber = const Value.absent(),
            Value<DateTime> scheduledAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isRead = const Value.absent(),
            Value<bool> isDelivered = const Value.absent(),
          }) =>
              NotificationsCompanion(
            id: id,
            title: title,
            body: body,
            type: type,
            orderId: orderId,
            orderNumber: orderNumber,
            scheduledAt: scheduledAt,
            createdAt: createdAt,
            isRead: isRead,
            isDelivered: isDelivered,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String body,
            required String type,
            Value<int?> orderId = const Value.absent(),
            Value<String?> orderNumber = const Value.absent(),
            required DateTime scheduledAt,
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isRead = const Value.absent(),
            Value<bool> isDelivered = const Value.absent(),
          }) =>
              NotificationsCompanion.insert(
            id: id,
            title: title,
            body: body,
            type: type,
            orderId: orderId,
            orderNumber: orderNumber,
            scheduledAt: scheduledAt,
            createdAt: createdAt,
            isRead: isRead,
            isDelivered: isDelivered,
          ),
        ));
}

class $$NotificationsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get body => $state.composableBuilder(
      column: $state.table.body,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get orderId => $state.composableBuilder(
      column: $state.table.orderId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get orderNumber => $state.composableBuilder(
      column: $state.table.orderNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get scheduledAt => $state.composableBuilder(
      column: $state.table.scheduledAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isRead => $state.composableBuilder(
      column: $state.table.isRead,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isDelivered => $state.composableBuilder(
      column: $state.table.isDelivered,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$NotificationsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get body => $state.composableBuilder(
      column: $state.table.body,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get orderId => $state.composableBuilder(
      column: $state.table.orderId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get orderNumber => $state.composableBuilder(
      column: $state.table.orderNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get scheduledAt => $state.composableBuilder(
      column: $state.table.scheduledAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isRead => $state.composableBuilder(
      column: $state.table.isRead,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isDelivered => $state.composableBuilder(
      column: $state.table.isDelivered,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$OrdersTableTableManager get orders =>
      $$OrdersTableTableManager(_db, _db.orders);
  $$ReceiptsTableTableManager get receipts =>
      $$ReceiptsTableTableManager(_db, _db.receipts);
  $$NotificationsTableTableManager get notifications =>
      $$NotificationsTableTableManager(_db, _db.notifications);
}

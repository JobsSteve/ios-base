4. TableView. Static Cells. Dynamic Cells.
==

##TableViewDataSource

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTableView];
}

- (void)setupTableView {
    self.tableView.allowsSelection = NO;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        SHGFineCarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHGFineCarCell"];
        
        //Configure Cell
        
        //Buttons
        [cell.carNumerButton addTarget:self
                                     action:@selector(carNumberButtonWasPressed:)
                           forControlEvents:UIControlEventTouchDown];
        [cell.carRegionButton addTarget:self
                                   action:@selector(regionButtonWasPressed:)
                         forControlEvents:UIControlEventTouchDown];
        [cell.carRegionButton addTarget:self
                                         action:@selector(registrationButtonWasPressed:)
                               forControlEvents:UIControlEventTouchDown];
        [cell.carRegistrationPromptButton addTarget:self
                                          action:@selector(registrationPromptButtonWasPressed:)
                                forControlEvents:UIControlEventTouchDown];
        
        return cell;
    }
    if (indexPath.row == 1) {
        SHGFineDriverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHGFineDriverCell"];
    
        [cell.driverLicenseButton addTarget:self
                                     action:@selector(driverLicenseButtonWasPressed:) forControlEvents:UIControlEventTouchDown];
        [cell.driverLicensePromptButton addTarget:self
                                           action:@selector(driverLicensePromptButton:)
                                 forControlEvents:UIControlEventTouchDown];
        
        return cell;
    }
    
    SHGButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHGButtonCell"];
    
    [cell.checkFinesButton addTarget:self
                              action:@selector(checkFinesButton:)
                    forControlEvents:UIControlEventTouchDown];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 190;
    }
    if (indexPath.row == 1) {
        return 127;
    }
    return 83;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


## Динамическая природа UITableView.

```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //ORDER ARRAY - для динамического построения ячеек.
    self.orderArray = [NSMutableArray new];
    
    //Создание объектов и добавление в self.orderArray
    //1.
    DBOrder *order = self.order;
    [self.orderArray addObject:order];
    
    //2.
    NSArray *fields = [DBRequiredField MR_findAll];
    self.fields = [fields mutableCopy];
    for (DBRequiredField *field in fields) {
        [self.orderArray addObject:field];
    }
    self.fieldsCount = fields.count;
    
    //3.
    NSDictionary *button = @{@"button": @"Перейти к оплате"};
    [self.orderArray addObject:button];
    
    //4.
    NSDictionary *condition = @{@"condition": @"Я соглашаюсь к условиям"};
    [self.orderArray addObject:condition];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self configureTableView];
    
    self.navigationItem.title = @"Оплата";
}

- (void)configureTableView
{
    //Если ячеек немного то позволяет рассчитать длину ячеек автоматически.
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orderArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //default cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    id detectObject = [self.orderArray objectAtIndex:indexPath.row];
    NSString *className = NSStringFromClass([detectObject class]);
    
    if ([className isEqualToString:@"DBOrder"]) {
        
        self.paramsCell = [tableView dequeueReusableCellWithIdentifier:@"SHGParamsOrderCell"];
    
        self.paramsCell.c_productsLabel.text = [NSString getVerbForFine:self.order.b_countValue];
        
        self.paramsCell.c_costLabel.text = [NSString stringWithFormat:@"%@ руб.", self.order.b_cost];
        NSNumber *comission = @(self.order.b_totalValue - self.order.b_costValue);
        self.paramsCell.c_comissionLabel.text = [NSString stringWithFormat:@"%@ руб.", comission];
        self.paramsCell.c_totalLabel.text = [NSString stringWithFormat:@"%@ руб.", self.order.b_total];
        
        return self.paramsCell;
    }
    
    else if ([className isEqualToString:@"DBRequiredField"]) {
        
        self.fieldCell = [tableView dequeueReusableCellWithIdentifier:@"SHGFieldOrderCell"];

        DBRequiredField *field = [DBRequiredField MR_findFirst];
        NSLog(@"field = %@", field.b_field);
        self.fieldCell.c_fieldTextField.placeholder = [NSString getPlaceholder:field.b_field];
        
        NSInteger index = indexPath.row; //от 1-го до n
        
        self.fieldCell.c_fieldTextField.tag = index;
        
        return self.fieldCell;
    }
    
    else if ([className isEqualToString:@"__NSDictionaryI"]) {
        
        NSLog(@"detectObject = %@", detectObject);
        NSDictionary *dict = (NSDictionary *)detectObject;
        NSArray *keys = [dict allKeys];
        NSString *key = [keys firstObject];
        
        if ([key isEqualToString:@"button"]) {
            self.buttonCell = [tableView dequeueReusableCellWithIdentifier:@"SHGButtonOrderCell"];
            [self.buttonCell.c_orderButton addTarget:self
                                         action:@selector(orderButtonWasPressed:)
                               forControlEvents:UIControlEventTouchUpInside];
            return self.buttonCell;
        }
        
        if ([key isEqualToString:@"condition"]) {
            self.conditionsCell = [tableView dequeueReusableCellWithIdentifier:@"SHGConditionsOrderCell"];
            [self.conditionsCell.c_conditionsButton addTarget:self
                                                  action:@selector(conditionsButtonWasPressed:)
                                        forControlEvents:UIControlEventTouchUpInside];
            return self.conditionsCell;
        }
    }
    return cell;
}
```







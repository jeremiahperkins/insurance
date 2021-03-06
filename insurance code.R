head(insurance)
insurance2 <- insurance %>% mutate(sex = factor(sex), smoker = factor(smoker), region = factor(region))
head(insurance2)
summary(insurance2)
rm(insurance)
ggplot(insurance2, aes(x = age, y = charges, color = smoker)) + geom_point(alpha = 0.6, shape = 16) + labs(insurance2, title = "Charges by Age", x = "Age", y = "Charges") + theme_classic()
ggplot(insurance2, aes(x = sex, fill = sex)) + geom_bar() + labs(insurance2, title = "Male/Female", x = "Sex", y = "Number of Males/Females") + theme_test()                                                                                                                  
ggplot(insurance2, aes(x = children)) + geom_bar() + labs(insurance2, title = "Children", x = "Childern", y = "Number of Children") + theme_light()                                                                                                                   
ggplot(insurance2, aes(x = region, fill = region, color = region)) + geom_bar() + labs(insurance2, title = "Regions", x = "Region", y = "Number of Regions") + theme_light()
ggplot(insurance2, aes(x = smoker, fill = smoker, region = smoker)) + geom_bar() + labs(insurance2, title = "Smokers", x = "Smokers vs Nonsmokers", y = "Number of Smokers") + theme_light()
insurance3 <- insurance2 %>% select(age, bmi, children, charges)
chart.Correlation(insurance3)
tibble <- tibble(low_charges = nrow(filter(insurance2, charges < 15000)), high_charges = nrow(filter(insurance2, charges > 50000)))
set.seed(123)
insurance_split <- initial_split(insurance2, prop = .80)
training_data <- training(insurance_split)
test_data <- testing(insurance_split)
dim(training_data)
dim(test_data)
model <- lm(charges ~ ., data = training_data)
insurance_predict <- predict(model, newdata = test_data)
error <- insurance_predict - test_data[["charges"]]
print(error)
sqrt(mean(error^2))
model2 <- train(charges ~ ., data = insurance2, method = "lm", trControl = trainControl(method = "cv", number = 10, verboseIter =  TRUE))
print(model2)
insurance_predict_final <- predict(model2, insurance2)
insurance_predict_dataframe <- data.frame(charges_predicted = predict(model2, insurance2))

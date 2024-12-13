/*
  Warnings:

  - Made the column `remark` on table `FoodSize` required. This step will fail if there are existing NULL values in that column.
  - Made the column `remark` on table `Taste` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "FoodSize" ALTER COLUMN "remark" SET NOT NULL,
ALTER COLUMN "moneyAdded" DROP DEFAULT;

-- AlterTable
ALTER TABLE "Taste" ALTER COLUMN "remark" SET NOT NULL;

-- AlterTable
ALTER TABLE "User" ALTER COLUMN "level" SET DEFAULT 'admin';

-- CreateTable
CREATE TABLE "Food" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "img" TEXT NOT NULL,
    "remark" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'use',
    "price" INTEGER NOT NULL,
    "foodType" TEXT NOT NULL DEFAULT 'food',
    "foodTypeId" INTEGER NOT NULL,

    CONSTRAINT "Food_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BillSale" (
    "id" SERIAL NOT NULL,
    "createdDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "payDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "amount" INTEGER NOT NULL,
    "payType" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "inputMoney" INTEGER NOT NULL,
    "returnMoney" INTEGER NOT NULL,
    "tableNo" INTEGER NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'use',

    CONSTRAINT "BillSale_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BillSaleDetail" (
    "id" SERIAL NOT NULL,
    "billSaleId" INTEGER NOT NULL,
    "foodId" INTEGER NOT NULL,
    "tasteId" INTEGER,
    "foodSizeId" INTEGER,
    "moneyAdded" INTEGER,
    "price" INTEGER,

    CONSTRAINT "BillSaleDetail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SaleTemp" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "tableNo" INTEGER NOT NULL,
    "foodId" INTEGER NOT NULL,
    "qty" INTEGER NOT NULL,

    CONSTRAINT "SaleTemp_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SaleTempDetail" (
    "id" SERIAL NOT NULL,
    "saleTempId" INTEGER NOT NULL,
    "foodId" INTEGER NOT NULL,
    "tasteId" INTEGER,
    "foodSizeId" INTEGER,

    CONSTRAINT "SaleTempDetail_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Food" ADD CONSTRAINT "Food_foodTypeId_fkey" FOREIGN KEY ("foodTypeId") REFERENCES "FoodType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BillSale" ADD CONSTRAINT "BillSale_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BillSaleDetail" ADD CONSTRAINT "BillSaleDetail_foodId_fkey" FOREIGN KEY ("foodId") REFERENCES "Food"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BillSaleDetail" ADD CONSTRAINT "BillSaleDetail_billSaleId_fkey" FOREIGN KEY ("billSaleId") REFERENCES "BillSale"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BillSaleDetail" ADD CONSTRAINT "BillSaleDetail_foodSizeId_fkey" FOREIGN KEY ("foodSizeId") REFERENCES "FoodSize"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BillSaleDetail" ADD CONSTRAINT "BillSaleDetail_tasteId_fkey" FOREIGN KEY ("tasteId") REFERENCES "Taste"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SaleTemp" ADD CONSTRAINT "SaleTemp_foodId_fkey" FOREIGN KEY ("foodId") REFERENCES "Food"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SaleTempDetail" ADD CONSTRAINT "SaleTempDetail_foodId_fkey" FOREIGN KEY ("foodId") REFERENCES "Food"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SaleTempDetail" ADD CONSTRAINT "SaleTempDetail_tasteId_fkey" FOREIGN KEY ("tasteId") REFERENCES "Taste"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SaleTempDetail" ADD CONSTRAINT "SaleTempDetail_foodSizeId_fkey" FOREIGN KEY ("foodSizeId") REFERENCES "FoodSize"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SaleTempDetail" ADD CONSTRAINT "SaleTempDetail_saleTempId_fkey" FOREIGN KEY ("saleTempId") REFERENCES "SaleTemp"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

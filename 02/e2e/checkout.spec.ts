import { expect, test } from "@playwright/test";

test.describe("Shop → Checkout", () => {
  type TestProduct = { slug: string; name: string; price: number };
  let testProducts: TestProduct[];

  test.beforeAll(async ({ request }) => {
    const runId = crypto.randomUUID().slice(0, 8);
    testProducts = [
      { slug: `e2e-${runId}-item-1`, name: `Item 1-${runId}`, price: 100 },
      { slug: `e2e-${runId}-item-2`, name: `Item 2-${runId}`, price: 1000 },
      { slug: `e2e-${runId}-item-3`, name: `Item 3-${runId}`, price: 999 },
    ];

    await test.step("Provide products", async () => {
      const response = await request.put("/api/test/products", {
        data: {
          products: testProducts,
        },
      });
      expect(response.status(), "Provide products failed").toBe(201);
    });
  });

  test.afterAll(async ({ request }) => {
    const slugs = testProducts.map((p) => p.slug);
    const response = await request.delete("/api/test/products", { data: { slugs } });
    expect(response.status(), "Delete products failed").toBe(200);
  });

  test("Given no item selected, checkout shows total 0", async ({ page }) => {
    await test.step("Go to shop page", async () => {
      await page.goto("/");
    });

    await test.step("Click go to checkout button", async () => {
      await page.getByRole("button", { name: "Go to checkout" }).click();
    });

    await test.step("Check total amount is 0", async () => {
      await expect(page.getByTestId("total-amount")).toHaveText("0");
    });
  });

  test("Given selected items, when amount is lower than 1000 no discount is applied", async ({
    page,
  }) => {
    await test.step("Go to shop page", async () => {
      await page.goto("/");
    });

    await test.step("Select item 1", async () => {
      await page.getByRole("checkbox", { name: testProducts[0].name }).check();
    });

    await test.step("Click go to checkout button", async () => {
      await page.getByRole("button", { name: "Go to checkout" }).click();
    });

    await test.step("Should have item 1 in the cart", async () => {
      await expect(page.getByTestId("cart-items")).toContainText(testProducts[0].name);
      await expect(page.getByTestId("cart-items")).toContainText(testProducts[0].price.toString());
    });

    await test.step("Check total amount is 100", async () => {
      await expect(page.getByTestId("total-amount")).toHaveText("100");
    });

    await test.step("Freebie shold be 0", async () => {
      await expect(page.getByTestId("freebies")).toHaveText("0");
    });
  });

  test("Given selected items, when total amount is greater than 1000 no discount is applied", async ({
    page,
  }) => {
    await test.step("Go to shop page", async () => {
      await page.goto("/");
    });

    await test.step("Select item 1", async () => {
      await page.getByRole("checkbox", { name: testProducts[0].name }).check();
    });
    await test.step("Select item 2", async () => {
      await page.getByRole("checkbox", { name: testProducts[1].name }).check();
    });

    await test.step("Click go to checkout button", async () => {
      await page.getByRole("button", { name: "Go to checkout" }).click();
    });

    await test.step("Should have item 1 in the cart", async () => {
      await expect(page.getByTestId("cart-items")).toContainText(testProducts[0].name);
      await expect(page.getByTestId("cart-items")).toContainText(testProducts[0].price.toString());
    });
    await test.step("Should have item 2 in the cart", async () => {
      await expect(page.getByTestId("cart-items")).toContainText(testProducts[1].name);
      await expect(page.getByTestId("cart-items")).toContainText(testProducts[1].price.toString());
    });

    await test.step("Check total amount is 990.0", async () => {
      await expect(page.getByTestId("total-amount")).toHaveText("990.0");
    });

    await test.step("Freebie shold be 0", async () => {
      await expect(page.getByTestId("freebies")).toHaveText("0");
    });
  });

  test("Given selected 3 items, get 1 freebies", async ({ page }) => {
    await test.step("Go to shop page", async () => {
      await page.goto("/");
    });

    await test.step("Select item 1", async () => {
      await page.getByRole("checkbox", { name: testProducts[0].name }).check();
    });
    await test.step("Select item 2", async () => {
      await page.getByRole("checkbox", { name: testProducts[1].name }).check();
    });
    await test.step("Select item 3", async () => {
      await page.getByRole("checkbox", { name: testProducts[2].name }).check();
    });

    await test.step("Click go to checkout button", async () => {
      await page.getByRole("button", { name: "Go to checkout" }).click();
    });

    await test.step("Should have item 1 in the cart", async () => {
      await expect(page.getByTestId("cart-items")).toContainText(testProducts[0].name);
      await expect(page.getByTestId("cart-items")).toContainText(testProducts[0].price.toString());
    });
    await test.step("Should have item 2 in the cart", async () => {
      await expect(page.getByTestId("cart-items")).toContainText(testProducts[1].name);
      await expect(page.getByTestId("cart-items")).toContainText(testProducts[1].price.toString());
    });
    await test.step("Should have item 3 in the cart", async () => {
      await expect(page.getByTestId("cart-items")).toContainText(testProducts[2].name);
      await expect(page.getByTestId("cart-items")).toContainText(testProducts[2].price.toString());
    });

    await test.step("Check total amount is correctly calculated", async () => {
      await expect(page.getByTestId("total-amount")).toHaveText(
        "1889.1000000000001",
      );
    });

    await test.step("Freebie shold be 1", async () => {
      await expect(page.getByTestId("freebies")).toHaveText("1");
    });
  });
});

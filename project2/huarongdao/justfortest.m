b = uibutton('state');

tc = matlab.uitest.TestCase.forInteractiveUse;
tc.verifyFalse(b.Value)
tc.press(b)
tc.verifyTrue(b.Value)
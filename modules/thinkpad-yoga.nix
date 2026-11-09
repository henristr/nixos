{...}: {
  programs.plasma.input = {
    touchpads = [
      {
        enable = true;
        name = "Default";
        vendorId = "0000";
        productId = "0000";
        tapToClick = true;
        naturalScroll = true;
        disableWhileTyping = true;
      }
    ];
  };
}

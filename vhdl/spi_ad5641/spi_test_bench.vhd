-- SPI AD5641 interface.

library ieee,work,std;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity spi_test_bench is
end entity;

architecture simulation of spi_test_bench is
    constant    clk_freq:     positive                        :=  1000000000;
    constant    clk_period:   time                            :=  1000 ms / clk_freq;

    signal      wait_flag:    std_logic                       :=  '0';
    signal      tb_clk:       std_logic                       :=  '0';
    signal      tb_rst:       std_logic                       :=  '1';
    signal      tb_ctrl_we:   std_logic                       :=  '0';
    signal      tb_ctrl_reg:  std_logic_vector(15 downto 0)   := (others => '0');
    signal      tb_idata_we:  std_logic                       :=  '0';
    signal      tb_idata:     std_logic_vector(15 downto 0)   := (others => '0');

    signal      tb_cs:        std_logic                       :=  '0';
    signal      tb_oclk:      std_logic                       :=  '0';
    signal      tb_odata:     std_logic                       :=  '0';
begin

  spi_ad5641_uut: entity work.spi_ad5641
  port map(
    clk       => tb_clk,
    rst       => tb_rst,
    ctrl_we   => tb_ctrl_we,
    ctrl_reg  => tb_ctrl_reg,
    idata_we  => tb_idata_we,
    idata     => tb_idata,
    cs        => tb_cs,
    oclk      => tb_oclk,
    odata     => tb_odata
          );

	clk_process: process
	begin
    while wait_flag = '0' loop
      tb_clk	<=	'1';
      wait for clk_period/2;
      tb_clk	<=	'0';
      wait for clk_period/2;
    end loop;
    wait;
	end process;

	stimulus_process: process
	begin
    wait for clk_period * 2;
    tb_rst <= '0';
    tb_idata_we <= '1';
    tb_idata <= X"8001";
    wait for clk_period * 1;
    tb_idata_we <= '0';
    wait for clk_period * 256;
    wait_flag   <=  '1';
    wait;
  end process;

end architecture;

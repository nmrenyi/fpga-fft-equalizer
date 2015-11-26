library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fft_output_former is
	generic (
		number_of_samples:          integer := 3; --for testing 3
		bits_per_sample:            integer := 2); --for testing 2
	port (
		reset_n:              in    std_logic;
		sample_available_to_dac:     out    std_logic;
		left_channel_sample_to_dac:  out    signed(bits_per_sample - 1 downto 0);
		right_channel_sample_to_dac: out    signed(bits_per_sample - 1 downto 0);
		
		vector_left:          in   std_logic_vector(number_of_samples * bits_per_sample - 1 downto 0) := (others => '0');
		vector_right:         in   std_logic_vector(number_of_samples * bits_per_sample - 1 downto 0) := (others => '0');
		new_vector:           in   std_logic := '0');
end fft_output_former;

architecture fft_output_former_impl of fft_output_former is
	type fsm is (idle, receive_data, available_data);
	signal state: fsm;

	signal vector_left_int:   std_logic_vector(number_of_samples * bits_per_sample - 1 downto 0) := (others => '0');
	signal vector_right_int:  std_logic_vector(number_of_samples * bits_per_sample - 1 downto 0) := (others => '0');

begin

	--process(reset_n, sample_available_from_adc)
	--	variable samples_remaining: integer := number_of_samples;
	--begin
	--	if (reset_n = '0') then
	--		vector_left <= (others => '0');
	--		vector_right <= (others => '0');
	--		vector_left_int <= (others => '0');
	--		vector_right_int <= (others => '0');
	--	elsif (rising_edge(sample_available_from_adc)) then
	--		case state is
	--			when idle =>
	--				new_vector <= '0';
	--				vector_left_int <= vector_left_int((number_of_samples - 1) * bits_per_sample - 1 downto 0) & std_logic_vector(left_channel_sample_from_adc);
	--				vector_right_int <= vector_right_int((number_of_samples - 1) * bits_per_sample - 1 downto 0) & std_logic_vector(right_channel_sample_from_adc);						
	--				samples_remaining := number_of_samples - 1;
	--				state <= receive_data;
	--			when receive_data =>	
	--				new_vector <= '0';
	--				if (samples_remaining > 1) then
	--					vector_left_int <= vector_left_int((number_of_samples - 1) * bits_per_sample - 1 downto 0) & std_logic_vector(left_channel_sample_from_adc);
	--					vector_right_int <= vector_right_int((number_of_samples - 1) * bits_per_sample - 1 downto 0) & std_logic_vector(right_channel_sample_from_adc);						
	--					samples_remaining := samples_remaining - 1;
	--				else
	--					vector_left <= vector_left_int((number_of_samples - 1) * bits_per_sample - 1 downto 0) & std_logic_vector(left_channel_sample_from_adc);
	--					vector_right <= vector_right_int((number_of_samples - 1) * bits_per_sample - 1 downto 0) & std_logic_vector(right_channel_sample_from_adc);
	--					state <= available_data;
	--				end if;

	--			when available_data =>
	--				new_vector <= '1';
	--				vector_left_int <= vector_left_int((number_of_samples - 1) * bits_per_sample - 1 downto 0) & std_logic_vector(left_channel_sample_from_adc);
	--				vector_right_int <= vector_right_int((number_of_samples - 1) * bits_per_sample - 1 downto 0) & std_logic_vector(right_channel_sample_from_adc);						
	--				samples_remaining := number_of_samples - 1;
	--				state <= receive_data;
	--		end case;
	--	end if;
	--end process;
end fft_output_former_impl;
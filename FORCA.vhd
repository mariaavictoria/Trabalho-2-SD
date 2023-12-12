
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

---- SENHA = 71650

entity FORCA is
Port (
		tentativa: in std_logic_vector (2 downto 0);
		reset : in std_logic := '0';
		clk: in std_logic;
		acertos: out std_logic_vector (4 downto 0);
		b_clk: in std_logic := '0';   -- LOADER
		vidas: out std_logic_vector (2 downto 0) := "111";
		vitoria: out std_logic; -- VITÓRIA
		derrota: out std_logic);  -- DERROTA
		
		
end FORCA;

-- SINAIS TEMPORÁRIOS (ALGUNS EXTRAS)

architecture Behavioral of FORCA is

signal m_acertos : std_logic_vector (4 downto 0) := "00000";
signal perdeu : std_logic_vector (2 downto 0) := "000";
signal m_vidas : std_logic_vector (2 downto 0) := "111"; 
signal m_b_clk : std_logic;
signal m_tentativa : std_logic_vector (2 downto 0);
signal m_vitoria : std_logic := '0';
signal m_derrota : std_logic:= '0';

begin

-- VERIFICANDO CADA CHUTE E REGISTRANDO ACERTOS

process (clk,reset) begin

if(clk' event and clk = '1') then

	case tentativa is

-- CHUTES CERTOS

	when "111" =>
		if (reset = '1') then
			m_acertos <= "00000"; 
			m_vitoria <= '0';
			m_derrota <= '0';
		end if;
		if (b_clk = '1') then
			m_acertos(4) <= '1';
		end if; 
		
	when "001" =>
		if (reset = '1') then
			m_acertos <= "00000";
			m_vitoria <= '0';
			m_derrota <= '0';
		end if;
		if (b_clk = '1') then
			m_acertos(3) <= '1';
		end if; 
		
		
	when "110" =>
		if (reset = '1') then
			m_acertos <= "00000";
			m_vitoria <= '0';
			m_derrota <= '0';
		end if;
		if (b_clk = '1') then
			m_acertos(2) <= '1';
		end if; 
	
		
	when "101" =>
		if (reset = '1') then
			m_acertos <= "00000"; 
			m_vitoria <= '0';
			m_derrota <= '0';
		end if;
		if (b_clk = '1') then
			m_acertos(1) <= '1';
		end if; 
		
		
	when "000" =>
		if (reset = '1') then
			m_acertos <= "00000"; 
			m_vitoria <= '0';
			m_derrota <= '0';
		end if;
		if (b_clk = '1') then
			m_acertos(0) <= '1';
		end if; 

-- CHUTES ERRADOS E PERDA DE VIDAS
		
	when "010" =>
		if (reset = '1') then
			m_acertos <= "00000"; 
			m_vitoria <= '0';
			m_derrota <= '0';
		end if;
		if (b_clk = '1' and perdeu(2) = '0') then
		if m_vidas(2) = '1' then
			m_vidas(2) <= '0';
			perdeu(2) <= '1';
		
		elsif m_vidas(1) = '1' then
			m_vidas(1) <= '0';
			perdeu(2) <= '1';
		
		elsif m_vidas(0) = '1' then
			m_vidas(0) <= '0';
			perdeu(2) <= '1';
	end if;
   end if;	
		
	when "011" =>
		if (reset = '1') then
			m_acertos <= "00000"; 
			m_vitoria <= '0';
			m_derrota <= '0';
		end if;
		if (b_clk = '1' and perdeu(1) = '0') then 
		if m_vidas(2) = '1' then
			m_vidas(2) <= '0';
			perdeu(1) <= '1';
		
		elsif m_vidas(1) = '1' then
			m_vidas(1) <= '0';
			perdeu(1) <= '1';
		
		elsif m_vidas(0) = '1' then
			m_vidas(0) <= '0';
			perdeu(1) <= '1';
	end if;
   end if;	
	
		
	when "100" =>
		if (reset = '1') then
			m_acertos <= "00000"; 
			m_vitoria <= '0';
			m_derrota <= '0';
		end if;
		if (b_clk = '1' and perdeu(0) = '0') then 
		if m_vidas(2) = '1' then
			m_vidas(2) <= '0';
			perdeu(0) <= '1';
		
		elsif m_vidas(1) = '1' then
			m_vidas(1) <= '0';
			perdeu(0) <= '1';
		
		elsif m_vidas(0) = '1' then
			m_vidas(0) <= '0';
			perdeu(0) <= '1';
	end if;
   end if;	
		
	when others =>
	NULL;
	end case;

end if;

-- VERIFICAÇÃO DA VITÓRIA

m_vitoria <= m_acertos(4) and m_acertos(3) and m_acertos(2) and m_acertos(1) and m_acertos(0);

-- VERIFICAÇÃO DA DERROTA (SOBREPÕE A VITÓRIA)

if (m_vidas = "000") then
m_vitoria <= '0';
m_derrota <= '1';
end if;
end process;

-- TRANSMISSÃO PARA VARIÁVEIS PERMANENTES

vidas <= m_vidas;
acertos <= m_acertos;
derrota <= m_derrota;
vitoria <= m_vitoria;
end Behavioral;

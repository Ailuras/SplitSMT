(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var2137 0)
(declare-sort var3698 0)
(declare-sort var751 0)
(declare-sort var1821 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getName/383349173 (var2137) String)
(define-fun toUpperCase/1156088314 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var751_getSystemProperty/1777521604 (String) String)
(declare-fun var1821_isEmpty/-813097145 (String) Bool)
(declare-const null-var2137 var2137)
(declare-const null-String String)
(declare-const var1405 var2137) ; Statement: r1 := @parameter0: org.apache.dubbo.config.ProtocolConfig 
(assert (not (= var1405 null-var2137)))
(declare-const var2886 String) ; Statement: r8 := @parameter1: java.lang.String 
(assert (not (= var2886 null-String)))
(define-const var2538 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2538)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2538!1 String)
(assert (= var2538!1 ""))
(assert true)
(define-const var971 String (getName/383349173 var1405)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.config.ProtocolConfig: java.lang.String getName()>() 
(assert true)
(define-const var3533 String (toUpperCase/1156088314 var971)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String toUpperCase()>() 
(assert true)
(define-const var974 String (append/672562846 var2538!1 var3533)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var2538!2 String)
(assert (= var2538!2 (str.++ var2538!1 var3533)))
(assert true)
(define-const var2455 String (append/672562846 var974 "_")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("_") 
(declare-const var974!1 String)
(assert (= var974!1 (str.++ var974 "_")))
(assert true)
(define-const var2894 String (toString/-2075883882 var2455)) ; Statement: r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var3655 String String-init) ; Statement: $r7 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3655)) ; Statement: specialinvoke $r7.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3655!1 String)
(assert (= var3655!1 ""))
(assert true)
(define-const var1958 String (append/672562846 var3655!1 var2894)) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r6) 
(declare-const var3655!2 String)
(assert (= var3655!2 (str.++ var3655!1 var2894)))
(assert true)
(define-const var515 String (append/672562846 var1958 var2886)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8) 
(declare-const var1958!1 String)
(assert (= var1958!1 (str.++ var1958 var2886)))
(assert true)
(define-const var2742 String (toString/-2075883882 var515)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var1865 String (var751_getSystemProperty/1777521604 var2742)) ; Statement: r12 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: java.lang.String getSystemProperty(java.lang.String)>($r11) 
(define-const var2704 Bool (var1821_isEmpty/-813097145 var1865)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r12) 
 ; Statement: if $z0 == 0 goto return r12 
(assert (= (ite var2704 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r12 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getName/383349173=([org.apache.dubbo.config.ProtocolConfig], java.lang.String), toUpperCase/1156088314=([java.lang.String], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var751_getSystemProperty/1777521604=([java.lang.String], java.lang.String), var1821_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2137=org.apache.dubbo.config.ProtocolConfig, var1405=r1, var2886=r8, var3698=null_type, var2538=$r0, var971=$r2, var3533=$r3, var974=$r4, var2455=$r5, var2894=r6, var3655=$r7, var1958=$r9, var515=$r10, var2742=$r11, var751=org.apache.dubbo.common.utils.ConfigUtils, var1865=r12, var1821=org.apache.dubbo.common.utils.StringUtils, var2704=$z0}
; {org.apache.dubbo.config.ProtocolConfig=var2137, r1=var1405, r8=var2886, null_type=var3698, $r0=var2538, $r2=var971, $r3=var3533, $r4=var974, $r5=var2455, r6=var2894, $r7=var3655, $r9=var1958, $r10=var515, $r11=var2742, org.apache.dubbo.common.utils.ConfigUtils=var751, r12=var1865, org.apache.dubbo.common.utils.StringUtils=var1821, $z0=var2704}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.String: java.lang.String toUpperCase()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.String: java.lang.String toUpperCase()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @parameter0: org.apache.dubbo.config.ProtocolConfig;	r8 := @parameter1: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.config.ProtocolConfig: java.lang.String getName()>();	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String toUpperCase()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("_");	r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	$r7 = new java.lang.StringBuilder;	specialinvoke $r7.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r6);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	r12 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: java.lang.String getSystemProperty(java.lang.String)>($r11);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r12);	if $z0 == 0 goto return r12;	return r12
;block_num 2
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

(declare-sort var3760 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3760_lineSeparator/-342590142 () String)
(define-fun toString/-2075883882 ((s String)) String s)
(define-const var1825 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1825)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1825!1 String)
(assert (= var1825!1 ""))
(assert true)
(define-const var729 String (append/672562846 var1825!1 "   ___   __  __ ___   ___   ____     ")) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("   ___   __  __ ___   ___   ____     ") 
(declare-const var1825!2 String)
(assert (= var1825!2 (str.++ var1825!1 "   ___   __  __ ___   ___   ____     ")))
(define-const var1526 String var3760_lineSeparator/-342590142) ; Statement: $r1 = staticinvoke <java.lang.System: java.lang.String lineSeparator()>() 
(assert true)
(define-const var2811 String (append/672562846 var729 var1526)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r1) 
(declare-const var729!1 String)
(assert (= var729!1 (str.++ var729 var1526)))
(assert true)
(define-const var499 String (append/672562846 var2811 "  / _ \u005c / / / // _ ) / _ ) / __ \u005c  ")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("  / _ \\ / / / // _ ) / _ ) / __ \\  ") 
(declare-const var2811!1 String)
(assert (= var2811!1 (str.++ var2811 "  / _ \u005c / / / // _ ) / _ ) / __ \u005c  ")))
(define-const var3653 String var3760_lineSeparator/-342590142) ; Statement: $r4 = staticinvoke <java.lang.System: java.lang.String lineSeparator()>() 
(assert true)
(define-const var1917 String (append/672562846 var499 var3653)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var499!1 String)
(assert (= var499!1 (str.++ var499 var3653)))
(assert true)
(define-const var1605 String (append/672562846 var1917 " / // // /_/ // _  |/ _  |/ /_/ /    ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" / // // /_/ // _  |/ _  |/ /_/ /    ") 
(declare-const var1917!1 String)
(assert (= var1917!1 (str.++ var1917 " / // // /_/ // _  |/ _  |/ /_/ /    ")))
(define-const var997 String var3760_lineSeparator/-342590142) ; Statement: $r7 = staticinvoke <java.lang.System: java.lang.String lineSeparator()>() 
(assert true)
(define-const var2501 String (append/672562846 var1605 var997)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var1605!1 String)
(assert (= var1605!1 (str.++ var1605 var997)))
(assert true)
(define-const var2135 String (append/672562846 var2501 "/____/ \u005c____//____//____/ \u005c____/   ")) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/____/ \\____//____//____/ \\____/   ") 
(declare-const var2501!1 String)
(assert (= var2501!1 (str.++ var2501 "/____/ \u005c____//____//____/ \u005c____/   ")))
(define-const var2965 String var3760_lineSeparator/-342590142) ; Statement: $r10 = staticinvoke <java.lang.System: java.lang.String lineSeparator()>() 
(assert true)
(define-const var3977 String (append/672562846 var2135 var2965)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var2135!1 String)
(assert (= var2135!1 (str.++ var2135 var2965)))
(assert true)
(define-const var3784 String (toString/-2075883882 var3977)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var550 String var3784) ; Statement: <org.apache.dubbo.qos.server.DubboLogo: java.lang.String DUBBO> = $r13 
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3760_lineSeparator/-342590142=([], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1825=$r0, var729=$r2, var3760=java.lang.System, var1526=$r1, var2811=$r3, var499=$r5, var3653=$r4, var1917=$r6, var1605=$r8, var997=$r7, var2501=$r9, var2135=$r11, var2965=$r10, var3977=$r12, var3784=$r13, var550=<org.apache.dubbo.qos.server.DubboLogo: java.lang.String DUBBO>}
; {$r0=var1825, $r2=var729, java.lang.System=var3760, $r1=var1526, $r3=var2811, $r5=var499, $r4=var3653, $r6=var1917, $r8=var1605, $r7=var997, $r9=var2501, $r11=var2135, $r10=var2965, $r12=var3977, $r13=var3784, <org.apache.dubbo.qos.server.DubboLogo: java.lang.String DUBBO>=var550}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 8,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts $r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("   ___   __  __ ___   ___   ____     ");	$r1 = staticinvoke <java.lang.System: java.lang.String lineSeparator()>();	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r1);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("  / _ \\ / / / // _ ) / _ ) / __ \\  ");	$r4 = staticinvoke <java.lang.System: java.lang.String lineSeparator()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" / // // /_/ // _  |/ _  |/ /_/ /    ");	$r7 = staticinvoke <java.lang.System: java.lang.String lineSeparator()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/____/ \\____//____//____/ \\____/   ");	$r10 = staticinvoke <java.lang.System: java.lang.String lineSeparator()>();	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	<org.apache.dubbo.qos.server.DubboLogo: java.lang.String DUBBO> = $r13;	return
;block_num 1
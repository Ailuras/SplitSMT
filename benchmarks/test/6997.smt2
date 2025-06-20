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

(declare-sort var1734 0)
(declare-sort var3125 0)
(declare-sort var3377 0)
(declare-sort var1562 0)
(declare-sort var2005 0)
(declare-sort var1037 0)
(declare-sort var2200 0)
(declare-sort var1608 0)
(declare-sort var3440 0)
(declare-sort var1615 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun file/-1225076988 (var1734) var3377)
(declare-fun var2005_getRootLogger/1438958744 () var1562)
(declare-fun getLevel/-1058280851 (var1562) var1037)
(declare-fun var2200-init () var2200)
(declare-fun <init>/-325640736 (var2200) void)
(declare-fun var1608_add/328494887 (var1608 var3440) Bool)
(declare-fun cast-from-var2200-to-var1608 (var2200) var1608)
(declare-fun cast-from-String-to-var3440 (String) var3440)
(declare-fun cast-from-var2200-to-var3440 (var2200) var3440)
(declare-fun var1615-init () var1615)
(declare-fun arr-String-init () (Array Int String))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getName/1128186653 (var3377) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-901862667 (String Int) String)
(declare-fun append/-1031950772 (String var3440) String)
(declare-fun cast-from-var1037-to-var3440 (var1037) var3440)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/581118162 (var1615 String String (Array Int String) var1608) void)
(declare-const null-var1734 var1734)
(declare-const null-var3125 var3125)
(declare-const null-var3377 var3377)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var3066 var1734) ; Statement: r0 := @this: com.alibaba.dubbo.container.page.pages.LogPageHandler 
(assert (not (= var3066 null-var1734)))
(declare-const var3934 var3125) ; Statement: r24 := @parameter0: com.alibaba.dubbo.common.URL 
(assert (not (= var3934 null-var3125)))
(define-const var2573 Int 0) ; Statement: l6 = 0L 
(define-const var737 String "") ; Statement: r25 = "" 
(define-const var2157 String "Not exist") ; Statement: r26 = "Not exist" 
(define-const var1658 var3377 (file/-1225076988 var3066)) ; Statement: $r1 = r0.<com.alibaba.dubbo.container.page.pages.LogPageHandler: java.io.File file> 
 ; Statement: if $r1 == null goto $r29 = staticinvoke <org.apache.log4j.LogManager: org.apache.log4j.Logger getRootLogger()>() 
(assert (= var1658 null-var3377)) ; Cond: $r1 == null 
(define-const var3162 var1562 var2005_getRootLogger/1438958744) ; Statement: $r29 = staticinvoke <org.apache.log4j.LogManager: org.apache.log4j.Logger getRootLogger()>() 
(assert true)
(define-const var2595 var1037 (getLevel/-1058280851 var3162)) ; Statement: $r30 = virtualinvoke $r29.<org.apache.log4j.Logger: org.apache.log4j.Level getLevel()>() 
(define-const var1940 var2200 var2200-init) ; Statement: $r40 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var1940)) ; Statement: specialinvoke $r40.<java.util.ArrayList: void <init>()>() 

(declare-const var1940!1 var2200)
(define-const var2112 var2200 var2200-init) ; Statement: $r41 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2112)) ; Statement: specialinvoke $r41.<java.util.ArrayList: void <init>()>() 

(declare-const var2112!1 var2200)
;(assert (var1608_add/328494887 (cast-from-var2200-to-var1608 var2112!1) (cast-from-String-to-var3440 var737))) ; Statement: interfaceinvoke $r41.<java.util.List: boolean add(java.lang.Object)>(r25) 

(declare-const var2112!2 var2200)
(declare-const var737!1 String)
;(assert (var1608_add/328494887 (cast-from-var2200-to-var1608 var1940!1) (cast-from-var2200-to-var3440 var2112!2))) ; Statement: interfaceinvoke $r40.<java.util.List: boolean add(java.lang.Object)>($r41) 

(declare-const var1940!2 var2200)
(declare-const var2112!3 var2200)
(define-const var3490 var1615 var1615-init) ; Statement: $r43 = new com.alibaba.dubbo.container.page.Page 
(define-const var2142 (Array Int String) arr-String-init) ; Statement: $r3 = newarray (java.lang.String)[1] 
(define-const var3801 String String-init) ; Statement: $r42 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3801)) ; Statement: specialinvoke $r42.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3801!1 String)
(assert (= var3801!1 ""))
(define-const var1723 var3377 (file/-1225076988 var3066)) ; Statement: $r34 = r0.<com.alibaba.dubbo.container.page.pages.LogPageHandler: java.io.File file> 
 ; Statement: if $r34 != null goto $r4 = r0.<com.alibaba.dubbo.container.page.pages.LogPageHandler: java.io.File file> 
(assert (not (= var1723 null-var3377))) ; Cond: $r34 != null 
(define-const var3543 var3377 (file/-1225076988 var3066)) ; Statement: $r4 = r0.<com.alibaba.dubbo.container.page.pages.LogPageHandler: java.io.File file> 
(assert true)
(define-const var1127 String (getName/1128186653 var3543)) ; Statement: $r35 = virtualinvoke $r4.<java.io.File: java.lang.String getName()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var959 String (append/672562846 var3801!1 var1127)) ; Statement: $r5 = virtualinvoke $r42.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r35) 
(declare-const var3801!2 String)
(assert (= var3801!2 (str.++ var3801!1 var1127)))
(assert true)
(define-const var621 String (append/672562846 var959 ", ")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ") 
(declare-const var959!1 String)
(assert (= var959!1 (str.++ var959 ", ")))
(assert true)
(define-const var3891 String (append/-901862667 var621 var2573)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l6) 
(declare-const var621!1 String)
(assert (str.prefixof var621 var621!1))
(assert true)
(define-const var3744 String (append/672562846 var3891 " bytes, ")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" bytes, ") 
(declare-const var3891!1 String)
(assert (= var3891!1 (str.++ var3891 " bytes, ")))
(assert true)
(define-const var494 String (append/672562846 var3744 var2157)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r26) 
(declare-const var3744!1 String)
(assert (= var3744!1 (str.++ var3744 var2157)))
(assert true)
(define-const var1414 String (append/672562846 var494 ", ")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ") 
(declare-const var494!1 String)
(assert (= var494!1 (str.++ var494 ", ")))
(assert true)
(define-const var193 String (append/-1031950772 var1414 (cast-from-var1037-to-var3440 var2595))) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r30) 
(declare-const var1414!1 String)
(assert (str.prefixof var1414 var1414!1))
(assert true)
(define-const var2017 String (toString/-2075883882 var193)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var2142!1 (Array Int String))
(assert (not (= var2142!1 null-__Array__Int__String__)))
(assert (= (select var2142!1 0) var2017)) ; Statement: $r3[0] = $r12 
(assert true)
;(assert (<init>/581118162 var3490 "Log" "Log" var2142!1 (cast-from-var2200-to-var1608 var1940!2))) ; Statement: specialinvoke $r43.<com.alibaba.dubbo.container.page.Page: void <init>(java.lang.String,java.lang.String,java.lang.String[],java.util.List)>("Log", "Log", $r3, $r40) 

(declare-const var3490!1 var1615)
(declare-const var33 String)
(declare-const var33!1 String)
(declare-const var2142!2 (Array Int String))
(declare-const var1940!3 var2200)
 ; Statement: return $r43 
(check-sat)
; {file/-1225076988=([com.alibaba.dubbo.container.page.pages.LogPageHandler], java.io.File), var2005_getRootLogger/1438958744=([], org.apache.log4j.Logger), getLevel/-1058280851=([org.apache.log4j.Logger], org.apache.log4j.Level), var2200-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), var1608_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var2200-to-var1608=([java.util.ArrayList], java.util.List), cast-from-String-to-var3440=([java.lang.String], java.lang.Object), cast-from-var2200-to-var3440=([java.util.ArrayList], java.lang.Object), var1615-init=([], com.alibaba.dubbo.container.page.Page), arr-String-init=([], java.lang.String[]), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getName/1128186653=([java.io.File], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1037-to-var3440=([org.apache.log4j.Level], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/581118162=([com.alibaba.dubbo.container.page.Page, java.lang.String, java.lang.String, java.lang.String[], java.util.List], void)}
; {var1734=com.alibaba.dubbo.container.page.pages.LogPageHandler, var3066=r0, var3125=com.alibaba.dubbo.common.URL, var3934=r24, var2573=l6, var737=r25, var2157=r26, var3377=java.io.File, var1658=$r1, var1562=org.apache.log4j.Logger, var2005=org.apache.log4j.LogManager, var3162=$r29, var1037=org.apache.log4j.Level, var2595=$r30, var2200=java.util.ArrayList, var1940=$r40, var2112=$r41, var1608=java.util.List, var3440=java.lang.Object, var1615=com.alibaba.dubbo.container.page.Page, var3490=$r43, var2142=$r3, var3801=$r42, var1723=$r34, var3543=$r4, var1127=$r35, var959=$r5, var621=$r6, var3891=$r7, var3744=$r8, var494=$r9, var1414=$r10, var193=$r11, var2017=$r12, var33="Log"}
; {com.alibaba.dubbo.container.page.pages.LogPageHandler=var1734, r0=var3066, com.alibaba.dubbo.common.URL=var3125, r24=var3934, l6=var2573, r25=var737, r26=var2157, java.io.File=var3377, $r1=var1658, org.apache.log4j.Logger=var1562, org.apache.log4j.LogManager=var2005, $r29=var3162, org.apache.log4j.Level=var1037, $r30=var2595, java.util.ArrayList=var2200, $r40=var1940, $r41=var2112, java.util.List=var1608, java.lang.Object=var3440, com.alibaba.dubbo.container.page.Page=var1615, $r43=var3490, $r3=var2142, $r42=var3801, $r34=var1723, $r4=var3543, $r35=var1127, $r5=var959, $r6=var621, $r7=var3891, $r8=var3744, $r9=var494, $r10=var1414, $r11=var193, $r12=var2017, "Log"=var33}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: com.alibaba.dubbo.container.page.pages.LogPageHandler;	r24 := @parameter0: com.alibaba.dubbo.common.URL;	l6 = 0L;	r25 = "";	r26 = "Not exist";	$r1 = r0.<com.alibaba.dubbo.container.page.pages.LogPageHandler: java.io.File file>;	if $r1 == null goto $r29 = staticinvoke <org.apache.log4j.LogManager: org.apache.log4j.Logger getRootLogger()>();	$r29 = staticinvoke <org.apache.log4j.LogManager: org.apache.log4j.Logger getRootLogger()>();	$r30 = virtualinvoke $r29.<org.apache.log4j.Logger: org.apache.log4j.Level getLevel()>();	$r40 = new java.util.ArrayList;	specialinvoke $r40.<java.util.ArrayList: void <init>()>();	$r41 = new java.util.ArrayList;	specialinvoke $r41.<java.util.ArrayList: void <init>()>();	interfaceinvoke $r41.<java.util.List: boolean add(java.lang.Object)>(r25);	interfaceinvoke $r40.<java.util.List: boolean add(java.lang.Object)>($r41);	$r43 = new com.alibaba.dubbo.container.page.Page;	$r3 = newarray (java.lang.String)[1];	$r42 = new java.lang.StringBuilder;	specialinvoke $r42.<java.lang.StringBuilder: void <init>()>();	$r34 = r0.<com.alibaba.dubbo.container.page.pages.LogPageHandler: java.io.File file>;	if $r34 != null goto $r4 = r0.<com.alibaba.dubbo.container.page.pages.LogPageHandler: java.io.File file>;	$r4 = r0.<com.alibaba.dubbo.container.page.pages.LogPageHandler: java.io.File file>;	$r35 = virtualinvoke $r4.<java.io.File: java.lang.String getName()>();	$r5 = virtualinvoke $r42.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r35);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l6);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" bytes, ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r26);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r30);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	$r3[0] = $r12;	specialinvoke $r43.<com.alibaba.dubbo.container.page.Page: void <init>(java.lang.String,java.lang.String,java.lang.String[],java.util.List)>("Log", "Log", $r3, $r40);	return $r43
;block_num 4
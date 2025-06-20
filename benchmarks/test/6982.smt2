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

(declare-sort var899 0)
(declare-sort var3928 0)
(declare-sort var3584 0)
(declare-sort var1368 0)
(declare-sort var3561 0)
(declare-sort var3490 0)
(declare-sort var747 0)
(declare-sort var2301 0)
(declare-sort var2037 0)
(declare-sort var373 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun file/-1225076988 (var899) var3584)
(declare-fun var3561_getRootLogger/1438958744 () var1368)
(declare-fun getLevel/-1058280851 (var1368) var3490)
(declare-fun var747-init () var747)
(declare-fun <init>/-325640736 (var747) void)
(declare-fun var2301_add/328494887 (var2301 var2037) Bool)
(declare-fun cast-from-var747-to-var2301 (var747) var2301)
(declare-fun cast-from-String-to-var2037 (String) var2037)
(declare-fun cast-from-var747-to-var2037 (var747) var2037)
(declare-fun var373-init () var373)
(declare-fun arr-String-init () (Array Int String))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-901862667 (String Int) String)
(declare-fun append/-1031950772 (String var2037) String)
(declare-fun cast-from-var3490-to-var2037 (var3490) var2037)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/581118162 (var373 String String (Array Int String) var2301) void)
(declare-const null-var899 var899)
(declare-const null-var3928 var3928)
(declare-const null-var3584 var3584)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var104 var899) ; Statement: r0 := @this: com.alibaba.dubbo.container.page.pages.LogPageHandler 
(assert (not (= var104 null-var899)))
(declare-const var396 var3928) ; Statement: r24 := @parameter0: com.alibaba.dubbo.common.URL 
(assert (not (= var396 null-var3928)))
(define-const var1802 Int 0) ; Statement: l6 = 0L 
(define-const var1859 String "") ; Statement: r25 = "" 
(define-const var3122 String "Not exist") ; Statement: r26 = "Not exist" 
(define-const var223 var3584 (file/-1225076988 var104)) ; Statement: $r1 = r0.<com.alibaba.dubbo.container.page.pages.LogPageHandler: java.io.File file> 
 ; Statement: if $r1 == null goto $r29 = staticinvoke <org.apache.log4j.LogManager: org.apache.log4j.Logger getRootLogger()>() 
(assert (= var223 null-var3584)) ; Cond: $r1 == null 
(define-const var3982 var1368 var3561_getRootLogger/1438958744) ; Statement: $r29 = staticinvoke <org.apache.log4j.LogManager: org.apache.log4j.Logger getRootLogger()>() 
(assert true)
(define-const var870 var3490 (getLevel/-1058280851 var3982)) ; Statement: $r30 = virtualinvoke $r29.<org.apache.log4j.Logger: org.apache.log4j.Level getLevel()>() 
(define-const var1521 var747 var747-init) ; Statement: $r40 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var1521)) ; Statement: specialinvoke $r40.<java.util.ArrayList: void <init>()>() 

(declare-const var1521!1 var747)
(define-const var890 var747 var747-init) ; Statement: $r41 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var890)) ; Statement: specialinvoke $r41.<java.util.ArrayList: void <init>()>() 

(declare-const var890!1 var747)
;(assert (var2301_add/328494887 (cast-from-var747-to-var2301 var890!1) (cast-from-String-to-var2037 var1859))) ; Statement: interfaceinvoke $r41.<java.util.List: boolean add(java.lang.Object)>(r25) 

(declare-const var890!2 var747)
(declare-const var1859!1 String)
;(assert (var2301_add/328494887 (cast-from-var747-to-var2301 var1521!1) (cast-from-var747-to-var2037 var890!2))) ; Statement: interfaceinvoke $r40.<java.util.List: boolean add(java.lang.Object)>($r41) 

(declare-const var1521!2 var747)
(declare-const var890!3 var747)
(define-const var2424 var373 var373-init) ; Statement: $r43 = new com.alibaba.dubbo.container.page.Page 
(define-const var2088 (Array Int String) arr-String-init) ; Statement: $r3 = newarray (java.lang.String)[1] 
(define-const var687 String String-init) ; Statement: $r42 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var687)) ; Statement: specialinvoke $r42.<java.lang.StringBuilder: void <init>()>() 
(declare-const var687!1 String)
(assert (= var687!1 ""))
(define-const var1070 var3584 (file/-1225076988 var104)) ; Statement: $r34 = r0.<com.alibaba.dubbo.container.page.pages.LogPageHandler: java.io.File file> 
 ; Statement: if $r34 != null goto $r4 = r0.<com.alibaba.dubbo.container.page.pages.LogPageHandler: java.io.File file> 
(assert (not (not (= var1070 null-var3584)))) ; Negate: Cond: $r34 != null  
(define-const var2534 String "") ; Statement: $r35 = "" 
 ; Statement: goto [?= $r5 = virtualinvoke $r42.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r35)] 
(assert true) ; Non Conditional
(assert true)
(define-const var2256 String (append/672562846 var687!1 var2534)) ; Statement: $r5 = virtualinvoke $r42.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r35) 
(declare-const var687!2 String)
(assert (= var687!2 (str.++ var687!1 var2534)))
(assert true)
(define-const var678 String (append/672562846 var2256 ", ")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ") 
(declare-const var2256!1 String)
(assert (= var2256!1 (str.++ var2256 ", ")))
(assert true)
(define-const var3867 String (append/-901862667 var678 var1802)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l6) 
(declare-const var678!1 String)
(assert (str.prefixof var678 var678!1))
(assert true)
(define-const var3850 String (append/672562846 var3867 " bytes, ")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" bytes, ") 
(declare-const var3867!1 String)
(assert (= var3867!1 (str.++ var3867 " bytes, ")))
(assert true)
(define-const var3672 String (append/672562846 var3850 var3122)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r26) 
(declare-const var3850!1 String)
(assert (= var3850!1 (str.++ var3850 var3122)))
(assert true)
(define-const var2121 String (append/672562846 var3672 ", ")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ") 
(declare-const var3672!1 String)
(assert (= var3672!1 (str.++ var3672 ", ")))
(assert true)
(define-const var113 String (append/-1031950772 var2121 (cast-from-var3490-to-var2037 var870))) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r30) 
(declare-const var2121!1 String)
(assert (str.prefixof var2121 var2121!1))
(assert true)
(define-const var1560 String (toString/-2075883882 var113)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var2088!1 (Array Int String))
(assert (not (= var2088!1 null-__Array__Int__String__)))
(assert (= (select var2088!1 0) var1560)) ; Statement: $r3[0] = $r12 
(assert true)
;(assert (<init>/581118162 var2424 "Log" "Log" var2088!1 (cast-from-var747-to-var2301 var1521!2))) ; Statement: specialinvoke $r43.<com.alibaba.dubbo.container.page.Page: void <init>(java.lang.String,java.lang.String,java.lang.String[],java.util.List)>("Log", "Log", $r3, $r40) 

(declare-const var2424!1 var373)
(declare-const var2193 String)
(declare-const var2193!1 String)
(declare-const var2088!2 (Array Int String))
(declare-const var1521!3 var747)
 ; Statement: return $r43 
(check-sat)
; {file/-1225076988=([com.alibaba.dubbo.container.page.pages.LogPageHandler], java.io.File), var3561_getRootLogger/1438958744=([], org.apache.log4j.Logger), getLevel/-1058280851=([org.apache.log4j.Logger], org.apache.log4j.Level), var747-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), var2301_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var747-to-var2301=([java.util.ArrayList], java.util.List), cast-from-String-to-var2037=([java.lang.String], java.lang.Object), cast-from-var747-to-var2037=([java.util.ArrayList], java.lang.Object), var373-init=([], com.alibaba.dubbo.container.page.Page), arr-String-init=([], java.lang.String[]), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3490-to-var2037=([org.apache.log4j.Level], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/581118162=([com.alibaba.dubbo.container.page.Page, java.lang.String, java.lang.String, java.lang.String[], java.util.List], void)}
; {var899=com.alibaba.dubbo.container.page.pages.LogPageHandler, var104=r0, var3928=com.alibaba.dubbo.common.URL, var396=r24, var1802=l6, var1859=r25, var3122=r26, var3584=java.io.File, var223=$r1, var1368=org.apache.log4j.Logger, var3561=org.apache.log4j.LogManager, var3982=$r29, var3490=org.apache.log4j.Level, var870=$r30, var747=java.util.ArrayList, var1521=$r40, var890=$r41, var2301=java.util.List, var2037=java.lang.Object, var373=com.alibaba.dubbo.container.page.Page, var2424=$r43, var2088=$r3, var687=$r42, var1070=$r34, var2534=$r35, var2256=$r5, var678=$r6, var3867=$r7, var3850=$r8, var3672=$r9, var2121=$r10, var113=$r11, var1560=$r12, var2193="Log"}
; {com.alibaba.dubbo.container.page.pages.LogPageHandler=var899, r0=var104, com.alibaba.dubbo.common.URL=var3928, r24=var396, l6=var1802, r25=var1859, r26=var3122, java.io.File=var3584, $r1=var223, org.apache.log4j.Logger=var1368, org.apache.log4j.LogManager=var3561, $r29=var3982, org.apache.log4j.Level=var3490, $r30=var870, java.util.ArrayList=var747, $r40=var1521, $r41=var890, java.util.List=var2301, java.lang.Object=var2037, com.alibaba.dubbo.container.page.Page=var373, $r43=var2424, $r3=var2088, $r42=var687, $r34=var1070, $r35=var2534, $r5=var2256, $r6=var678, $r7=var3867, $r8=var3850, $r9=var3672, $r10=var2121, $r11=var113, $r12=var1560, "Log"=var2193}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: com.alibaba.dubbo.container.page.pages.LogPageHandler;	r24 := @parameter0: com.alibaba.dubbo.common.URL;	l6 = 0L;	r25 = "";	r26 = "Not exist";	$r1 = r0.<com.alibaba.dubbo.container.page.pages.LogPageHandler: java.io.File file>;	if $r1 == null goto $r29 = staticinvoke <org.apache.log4j.LogManager: org.apache.log4j.Logger getRootLogger()>();	$r29 = staticinvoke <org.apache.log4j.LogManager: org.apache.log4j.Logger getRootLogger()>();	$r30 = virtualinvoke $r29.<org.apache.log4j.Logger: org.apache.log4j.Level getLevel()>();	$r40 = new java.util.ArrayList;	specialinvoke $r40.<java.util.ArrayList: void <init>()>();	$r41 = new java.util.ArrayList;	specialinvoke $r41.<java.util.ArrayList: void <init>()>();	interfaceinvoke $r41.<java.util.List: boolean add(java.lang.Object)>(r25);	interfaceinvoke $r40.<java.util.List: boolean add(java.lang.Object)>($r41);	$r43 = new com.alibaba.dubbo.container.page.Page;	$r3 = newarray (java.lang.String)[1];	$r42 = new java.lang.StringBuilder;	specialinvoke $r42.<java.lang.StringBuilder: void <init>()>();	$r34 = r0.<com.alibaba.dubbo.container.page.pages.LogPageHandler: java.io.File file>;	if $r34 != null goto $r4 = r0.<com.alibaba.dubbo.container.page.pages.LogPageHandler: java.io.File file>;	$r35 = "";	goto [?= $r5 = virtualinvoke $r42.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r35)];	$r5 = virtualinvoke $r42.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r35);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l6);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" bytes, ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r26);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r30);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	$r3[0] = $r12;	specialinvoke $r43.<com.alibaba.dubbo.container.page.Page: void <init>(java.lang.String,java.lang.String,java.lang.String[],java.util.List)>("Log", "Log", $r3, $r40);	return $r43
;block_num 4
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

(declare-sort var1884 0)
(declare-sort var314 0)
(declare-sort var2353 0)
(declare-sort var3083 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun unexported/14293649 (var1884) Bool)
(declare-fun var2353-init () var2353)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun interfaceClass/2052580610 (var3083) ClassObject)
(declare-fun cast-from-var1884-to-var3083 (var1884) var3083)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var2353 String) void)
(declare-const null-var1884 var1884)
(declare-const null-var314 var314)
(declare-const var1113 var1884) ; Statement: r0 := @this: org.apache.dubbo.config.ServiceConfig 
(assert (not (= var1113 null-var1884)))
(declare-const var3244 var314) ; Statement: r2 := @parameter0: org.apache.dubbo.common.constants.RegisterTypeEnum 
(assert (not (= var3244 null-var314)))
(define-const var1217 Bool (unexported/14293649 var1113)) ; Statement: $z0 = r0.<org.apache.dubbo.config.ServiceConfig: boolean unexported> 
 ; Statement: if $z0 == 0 goto $z1 = r0.<org.apache.dubbo.config.ServiceConfig: boolean exported> 
(assert (not (= (ite var1217 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var200 var2353 var2353-init) ; Statement: $r4 = new java.lang.IllegalStateException 
(define-const var750 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var750)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var750!1 String)
(assert (= var750!1 ""))
(assert true)
(define-const var1924 String (append/672562846 var750!1 "The service ")) ; Statement: $r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("The service ") 
(declare-const var750!2 String)
(assert (= var750!2 (str.++ var750!1 "The service ")))
(define-const var1056 ClassObject (interfaceClass/2052580610 (cast-from-var1884-to-var3083 var1113))) ; Statement: $r6 = r0.<org.apache.dubbo.config.ServiceConfig: java.lang.Class interfaceClass> 
(assert true)
(define-const var739 String (getName/-1958580599 var1056)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1223 String (append/672562846 var1924 var739)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var1924!1 String)
(assert (= var1924!1 (str.++ var1924 var739)))
(assert true)
(define-const var3717 String (append/672562846 var1223 " has already unexported!")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" has already unexported!") 
(declare-const var1223!1 String)
(assert (= var1223!1 (str.++ var1223 " has already unexported!")))
(assert true)
(define-const var1458 String (toString/-2075883882 var3717)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var200 var1458)) ; Statement: specialinvoke $r4.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r11) 

(declare-const var200!1 var2353)
(declare-const var1458!1 String)
 ; Statement: throw $r4 
(check-sat)
; {unexported/14293649=([org.apache.dubbo.config.ServiceConfig], boolean), var2353-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), interfaceClass/2052580610=([org.apache.dubbo.config.ServiceConfigBase], java.lang.Class), cast-from-var1884-to-var3083=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.ServiceConfigBase), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var1884=org.apache.dubbo.config.ServiceConfig, var1113=r0, var314=org.apache.dubbo.common.constants.RegisterTypeEnum, var3244=r2, var1217=$z0, var2353=java.lang.IllegalStateException, var200=$r4, var750=$r5, var1924=$r8, var3083=org.apache.dubbo.config.ServiceConfigBase, var1056=$r6, var739=$r7, var1223=$r9, var3717=$r10, var1458=$r11}
; {org.apache.dubbo.config.ServiceConfig=var1884, r0=var1113, org.apache.dubbo.common.constants.RegisterTypeEnum=var314, r2=var3244, $z0=var1217, java.lang.IllegalStateException=var2353, $r4=var200, $r5=var750, $r8=var1924, org.apache.dubbo.config.ServiceConfigBase=var3083, $r6=var1056, $r7=var739, $r9=var1223, $r10=var3717, $r11=var1458}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ServiceConfig;	r2 := @parameter0: org.apache.dubbo.common.constants.RegisterTypeEnum;	$z0 = r0.<org.apache.dubbo.config.ServiceConfig: boolean unexported>;	if $z0 == 0 goto $z1 = r0.<org.apache.dubbo.config.ServiceConfig: boolean exported>;	$r4 = new java.lang.IllegalStateException;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("The service ");	$r6 = r0.<org.apache.dubbo.config.ServiceConfig: java.lang.Class interfaceClass>;	$r7 = virtualinvoke $r6.<java.lang.Class: java.lang.String getName()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" has already unexported!");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r4.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r11);	throw $r4
;block_num 2
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

(declare-sort var208 0)
(declare-sort var110 0)
(declare-sort var46 0)
(declare-sort var572 0)
(declare-sort var2350 0)
(declare-sort var675 0)
(declare-sort var3609 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2350_getClass/1258963082 (var2350) ClassObject)
(declare-fun cast-from-var208-to-var2350 (var208) var2350)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var572_error/377575788 (var572 String String String String var675) void)
(declare-fun cast-from-var46-to-var675 (var46) var675)
(declare-fun var3609-init () var3609)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun <init>/-1447874194 (var3609 String var675) void)
(declare-const null-var208 var208)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-var46 var46)
(declare-const var208-interfaceLevelLogger var572)
(declare-const var739 var208) ; Statement: r0 := @this: org.apache.dubbo.common.config.Configuration 
(assert (not (= var739 null-var208)))
(declare-const var3481 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3481 null-String)))
(declare-const var919 Int) ; Statement: r2 := @parameter1: java.lang.Integer 
(assert (not (= var919 null-Int)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3557 var46) ; Statement: $r5 := @caughtexception 
(assert (not (= var3557 null-var46)))
(define-const var3275 var572 var208-interfaceLevelLogger) ; Statement: $r7 = <org.apache.dubbo.common.config.Configuration: org.apache.dubbo.common.logger.ErrorTypeAwareLogger interfaceLevelLogger> 
(define-const var2698 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2698)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2698!1 String)
(assert (= var2698!1 ""))
(assert true)
(define-const var1235 String (append/672562846 var2698!1 "Actual Class: ")) ; Statement: $r10 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Actual Class: ") 
(declare-const var2698!2 String)
(assert (= var2698!2 (str.++ var2698!1 "Actual Class: ")))
(define-const var3519 ClassObject (var2350_getClass/1258963082 (cast-from-var208-to-var2350 var739))) ; Statement: $r8 = interfaceinvoke r0.<org.apache.dubbo.common.config.Configuration: java.lang.Class getClass()>() 
(assert true)
(define-const var2710 String (getName/-1958580599 var3519)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3742 String (append/672562846 var1235 var2710)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var1235!1 String)
(assert (= var1235!1 (str.++ var1235 var2710)))
(assert true)
(define-const var2312 String (toString/-2075883882 var3742)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var572_error/377575788 var3275 "0-2" "typo in property value" "This property requires an integer value." var2312 (cast-from-var46-to-var675 var3557))) ; Statement: interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-2", "typo in property value", "This property requires an integer value.", $r12, $r5) 

(declare-const var3275!1 var572)
(declare-const var2506 String)
(declare-const var2706 String)
(declare-const var3029 String)
(declare-const var2312!1 String)
(declare-const var3557!1 var46)
(define-const var1337 var3609 var3609-init) ; Statement: $r13 = new java.lang.IllegalStateException 
(define-const var2812 String String-init) ; Statement: $r14 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2812)) ; Statement: specialinvoke $r14.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2812!1 String)
(assert (= var2812!1 ""))
(assert true)
(define-const var3298 String (append/-1166366385 var2812!1 39)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var2812!2 String)
(assert (str.prefixof var2812!1 var2812!2))
(assert true)
(define-const var1436 String (append/672562846 var3298 var3481)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var3298!1 String)
(assert (= var3298!1 (str.++ var3298 var3481)))
(assert true)
(define-const var3956 String (append/672562846 var1436 "\u0027 doesn\u0027t map to a Integer object")) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\' doesn\'t map to a Integer object") 
(declare-const var1436!1 String)
(assert (= var1436!1 (str.++ var1436 "\u0027 doesn\u0027t map to a Integer object")))
(assert true)
(define-const var782 String (toString/-2075883882 var3956)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1447874194 var1337 var782 (cast-from-var46-to-var675 var3557!1))) ; Statement: specialinvoke $r13.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r18, $r5) 

(declare-const var1337!1 var3609)
(declare-const var782!1 String)
(declare-const var3557!2 var46)
 ; Statement: throw $r13 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2350_getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var208-to-var2350=([org.apache.dubbo.common.config.Configuration], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var572_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var46-to-var675=([java.lang.NumberFormatException], java.lang.Throwable), var3609-init=([], java.lang.IllegalStateException), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), <init>/-1447874194=([java.lang.IllegalStateException, java.lang.String, java.lang.Throwable], void)}
; {var208=org.apache.dubbo.common.config.Configuration, var739=r0, var3481=r1, var110=null_type, var919=r2, var46=java.lang.NumberFormatException, var3557=$r5, var572=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3275=$r7, var2698=$r6, var1235=$r10, var2350=java.lang.Object, var3519=$r8, var2710=$r9, var3742=$r11, var2312=$r12, var675=java.lang.Throwable, var2506="0-2", var2706="typo in property value", var3029="This property requires an integer value.", var3609=java.lang.IllegalStateException, var1337=$r13, var2812=$r14, var3298=$r15, var1436=$r16, var3956=$r17, var782=$r18}
; {org.apache.dubbo.common.config.Configuration=var208, r0=var739, r1=var3481, null_type=var110, r2=var919, java.lang.NumberFormatException=var46, $r5=var3557, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var572, $r7=var3275, $r6=var2698, $r10=var1235, java.lang.Object=var2350, $r8=var3519, $r9=var2710, $r11=var3742, $r12=var2312, java.lang.Throwable=var675, "0-2"=var2506, "typo in property value"=var2706, "This property requires an integer value."=var3029, java.lang.IllegalStateException=var3609, $r13=var1337, $r14=var2812, $r15=var3298, $r16=var1436, $r17=var3956, $r18=var782}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.config.Configuration;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.Integer;	$r5 := @caughtexception;	$r7 = <org.apache.dubbo.common.config.Configuration: org.apache.dubbo.common.logger.ErrorTypeAwareLogger interfaceLevelLogger>;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Actual Class: ");	$r8 = interfaceinvoke r0.<org.apache.dubbo.common.config.Configuration: java.lang.Class getClass()>();	$r9 = virtualinvoke $r8.<java.lang.Class: java.lang.String getName()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-2", "typo in property value", "This property requires an integer value.", $r12, $r5);	$r13 = new java.lang.IllegalStateException;	$r14 = new java.lang.StringBuilder;	specialinvoke $r14.<java.lang.StringBuilder: void <init>()>();	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\' doesn\'t map to a Integer object");	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r13.<java.lang.IllegalStateException: void <init>(java.lang.String,java.lang.Throwable)>($r18, $r5);	throw $r13
;block_num 2
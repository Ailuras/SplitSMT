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

(declare-sort var1073 0)
(declare-sort var3263 0)
(declare-sort var3435 0)
(declare-sort var151 0)
(declare-sort var2790 0)
(declare-sort var3588 0)
(declare-sort var3246 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getConfig/-140576284 (var1073 ClassObject String) var2790)
(declare-fun isPresent/580259846 (var2790) Bool)
(declare-fun var3246-init () var3246)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var3246 String) void)
(declare-const null-var1073 var1073)
(declare-const null-ClassObject ClassObject)
(declare-const null-var3263 var3263)
(declare-const null-var3435 var3435)
(declare-const null-String String)
(declare-const null-var3588 var3588)
(declare-const var241 var1073) ; Statement: r0 := @this: org.apache.dubbo.config.context.AbstractConfigManager 
(assert (not (= var241 null-var1073)))
(declare-const var838 ClassObject) ; Statement: r1 := @parameter0: java.lang.Class 
(assert (not (= var838 null-ClassObject)))
(declare-const var1983 var3263) ; Statement: r13 := @parameter1: org.apache.dubbo.common.config.PropertiesConfiguration 
(assert (not (= var1983 null-var3263)))
(declare-const var666 var3435) ; Statement: r15 := @parameter2: java.util.List 
(assert (not (= var666 null-var3435)))
(declare-const var2185 String) ; Statement: r2 := @parameter3: java.lang.String 
(assert (not (= var2185 null-String)))
(assert true)
(define-const var2215 var2790 (getConfig/-140576284 var241 var838 var2185)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.config.context.AbstractConfigManager: java.util.Optional getConfig(java.lang.Class,java.lang.String)>(r1, r2) 
(assert true)
(define-const var641 Bool (isPresent/580259846 var2215)) ; Statement: $z0 = virtualinvoke $r3.<java.util.Optional: boolean isPresent()>() 
 ; Statement: if $z0 != 0 goto return 
(assert (not (not (= (ite var641 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(declare-const var2484 var3588) ; Statement: $r34 := @caughtexception 
(assert (not (= var2484 null-var3588)))
(define-const var3592 var3246 var3246-init) ; Statement: $r35 = new java.lang.IllegalStateException 
(define-const var1697 String String-init) ; Statement: $r36 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1697)) ; Statement: specialinvoke $r36.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1697!1 String)
(assert (= var1697!1 ""))
(assert true)
(define-const var2827 String (append/672562846 var1697!1 "create config instance failed, id: ")) ; Statement: $r37 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("create config instance failed, id: ") 
(declare-const var1697!2 String)
(assert (= var1697!2 (str.++ var1697!1 "create config instance failed, id: ")))
(assert true)
(define-const var2265 String (append/672562846 var2827 var2185)) ; Statement: $r38 = virtualinvoke $r37.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var2827!1 String)
(assert (= var2827!1 (str.++ var2827 var2185)))
(assert true)
(define-const var2558 String (append/672562846 var2265 ", type:")) ; Statement: $r40 = virtualinvoke $r38.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", type:") 
(declare-const var2265!1 String)
(assert (= var2265!1 (str.++ var2265 ", type:")))
(assert true)
(define-const var12 String (getSimpleName/-390194377 var838)) ; Statement: $r39 = virtualinvoke r1.<java.lang.Class: java.lang.String getSimpleName()>() 
(assert true)
(define-const var2786 String (append/672562846 var2558 var12)) ; Statement: $r41 = virtualinvoke $r40.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r39) 
(declare-const var2558!1 String)
(assert (= var2558!1 (str.++ var2558 var12)))
(assert true)
(define-const var3133 String (toString/-2075883882 var2786)) ; Statement: $r42 = virtualinvoke $r41.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var3592 var3133)) ; Statement: specialinvoke $r35.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r42) 

(declare-const var3592!1 var3246)
(declare-const var3133!1 String)
 ; Statement: throw $r35 
(check-sat)
; {getConfig/-140576284=([org.apache.dubbo.config.context.AbstractConfigManager, java.lang.Class, java.lang.String], java.util.Optional), isPresent/580259846=([java.util.Optional], boolean), var3246-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getSimpleName/-390194377=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var1073=org.apache.dubbo.config.context.AbstractConfigManager, var241=r0, var838=r1, var3263=org.apache.dubbo.common.config.PropertiesConfiguration, var1983=r13, var3435=java.util.List, var666=r15, var2185=r2, var151=null_type, var2790=java.util.Optional, var2215=$r3, var641=$z0, var3588=java.lang.Exception, var2484=$r34, var3246=java.lang.IllegalStateException, var3592=$r35, var1697=$r36, var2827=$r37, var2265=$r38, var2558=$r40, var12=$r39, var2786=$r41, var3133=$r42}
; {org.apache.dubbo.config.context.AbstractConfigManager=var1073, r0=var241, r1=var838, org.apache.dubbo.common.config.PropertiesConfiguration=var3263, r13=var1983, java.util.List=var3435, r15=var666, r2=var2185, null_type=var151, java.util.Optional=var2790, $r3=var2215, $z0=var641, java.lang.Exception=var3588, $r34=var2484, java.lang.IllegalStateException=var3246, $r35=var3592, $r36=var1697, $r37=var2827, $r38=var2265, $r40=var2558, $r39=var12, $r41=var2786, $r42=var3133}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.config.context.AbstractConfigManager;	r1 := @parameter0: java.lang.Class;	r13 := @parameter1: org.apache.dubbo.common.config.PropertiesConfiguration;	r15 := @parameter2: java.util.List;	r2 := @parameter3: java.lang.String;	$r3 = virtualinvoke r0.<org.apache.dubbo.config.context.AbstractConfigManager: java.util.Optional getConfig(java.lang.Class,java.lang.String)>(r1, r2);	$z0 = virtualinvoke $r3.<java.util.Optional: boolean isPresent()>();	if $z0 != 0 goto return;	$r34 := @caughtexception;	$r35 = new java.lang.IllegalStateException;	$r36 = new java.lang.StringBuilder;	specialinvoke $r36.<java.lang.StringBuilder: void <init>()>();	$r37 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("create config instance failed, id: ");	$r38 = virtualinvoke $r37.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r40 = virtualinvoke $r38.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", type:");	$r39 = virtualinvoke r1.<java.lang.Class: java.lang.String getSimpleName()>();	$r41 = virtualinvoke $r40.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r39);	$r42 = virtualinvoke $r41.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r35.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r42);	throw $r35
;block_num 2
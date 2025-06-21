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

(declare-sort var3684 0)
(declare-sort var2471 0)
(declare-sort var18 0)
(declare-sort var2174 0)
(declare-sort var2914 0)
(declare-sort var3802 0)
(declare-sort var1316 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2471!class ClassObject)
(declare-fun <init>/-596243380 (var18) void)
(declare-fun cast-from-var3684-to-var18 (var3684) var18)
(declare-fun appendAnnotation/1947190543 (var2174 ClassObject var2914) void)
(declare-fun cast-from-var3684-to-var2174 (var3684) var2174)
(declare-fun cast-from-var2471-to-var2914 (var2471) var2914)
(declare-fun var2471_isReturn/-1644516759 (var2471) Bool)
(declare-fun var3802_valueOf/1602327315 (Bool) var3802)
(declare-fun setReturn/-471685518 (var3684 var3802) void)
(declare-fun var2471_oninvoke/1545837869 (var2471) String)
(declare-fun var2471_onreturn/-1938273931 (var2471) String)
(declare-fun var2471_onthrow/-2012856209 (var2471) String)
(declare-fun var2471_arguments/-78858477 (var2471) (Array Int var1316))
(declare-const null-var3684 var3684)
(declare-const null-var2471 var2471)
(declare-const null-__Array__Int__var1316__ (Array Int var1316))
(declare-const var3249 var3684) ; Statement: r0 := @this: org.apache.dubbo.config.MethodConfig 
(assert (not (= var3249 null-var3684)))
(declare-const var345 var2471) ; Statement: r1 := @parameter0: org.apache.dubbo.config.annotation.Method 
(assert (not (= var345 null-var2471)))
(assert true)
;(assert (<init>/-596243380 (cast-from-var3684-to-var18 var3249))) ; Statement: specialinvoke r0.<org.apache.dubbo.config.AbstractMethodConfig: void <init>()>() 

(declare-const var3249!1 var3684)
(assert true)
;(assert (appendAnnotation/1947190543 (cast-from-var3684-to-var2174 var3249!1) var2471!class (cast-from-var2471-to-var2914 var345))) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: void appendAnnotation(java.lang.Class,java.lang.Object)>(class "Lorg/apache/dubbo/config/annotation/Method;", r1) 

(declare-const var3249!2 var3684)
(declare-const var1325 ClassObject)
(declare-const var345!1 var2471)
(define-const var874 Bool (var2471_isReturn/-1644516759 var345!1)) ; Statement: $z0 = interfaceinvoke r1.<org.apache.dubbo.config.'annotation'.Method: boolean isReturn()>() 
(define-const var3472 var3802 (var3802_valueOf/1602327315 var874)) ; Statement: $r2 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>($z0) 
(assert true)
;(assert (setReturn/-471685518 var3249!2 var3472)) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: void setReturn(java.lang.Boolean)>($r2) 

(declare-const var3249!3 var3684)
(declare-const var3472!1 var3802)
(define-const var71 String "") ; Statement: $r4 = "" 
(define-const var1143 String (var2471_oninvoke/1545837869 var345!1)) ; Statement: $r3 = interfaceinvoke r1.<org.apache.dubbo.config.'annotation'.Method: java.lang.String oninvoke()>() 
(assert true)
(define-const var1493 Bool (= var71 var1143)) ; Statement: $z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>($r3) 
 ; Statement: if $z1 != 0 goto $r26 = "" 
(assert (not (= (ite var1493 1 0) 0))) ; Cond: $z1 != 0 
(define-const var1558 String "") ; Statement: $r26 = "" 
(define-const var1744 String (var2471_onreturn/-1938273931 var345!1)) ; Statement: $r27 = interfaceinvoke r1.<org.apache.dubbo.config.'annotation'.Method: java.lang.String onreturn()>() 
(assert true)
(define-const var1488 Bool (= var1558 var1744)) ; Statement: $z2 = virtualinvoke $r26.<java.lang.String: boolean equals(java.lang.Object)>($r27) 
 ; Statement: if $z2 != 0 goto $r30 = "" 
(assert (not (= (ite var1488 1 0) 0))) ; Cond: $z2 != 0 
(define-const var2571 String "") ; Statement: $r30 = "" 
(define-const var2327 String (var2471_onthrow/-2012856209 var345!1)) ; Statement: $r31 = interfaceinvoke r1.<org.apache.dubbo.config.'annotation'.Method: java.lang.String onthrow()>() 
(assert true)
(define-const var782 Bool (= var2571 var2327)) ; Statement: $z3 = virtualinvoke $r30.<java.lang.String: boolean equals(java.lang.Object)>($r31) 
 ; Statement: if $z3 != 0 goto $r34 = interfaceinvoke r1.<org.apache.dubbo.config.'annotation'.Method: org.apache.dubbo.config.'annotation'.Argument[] arguments()>() 
(assert (not (= (ite var782 1 0) 0))) ; Cond: $z3 != 0 
(define-const var3816 (Array Int var1316) (var2471_arguments/-78858477 var345!1)) ; Statement: $r34 = interfaceinvoke r1.<org.apache.dubbo.config.'annotation'.Method: org.apache.dubbo.config.'annotation'.Argument[] arguments()>() 
 ; Statement: if $r34 == null goto return 
(assert (= var3816 null-__Array__Int__var1316__)) ; Cond: $r34 == null 
 ; Statement: return 
(check-sat)
; {<init>/-596243380=([org.apache.dubbo.config.AbstractMethodConfig], void), cast-from-var3684-to-var18=([org.apache.dubbo.config.MethodConfig], org.apache.dubbo.config.AbstractMethodConfig), appendAnnotation/1947190543=([org.apache.dubbo.config.AbstractConfig, java.lang.Class, java.lang.Object], void), cast-from-var3684-to-var2174=([org.apache.dubbo.config.MethodConfig], org.apache.dubbo.config.AbstractConfig), cast-from-var2471-to-var2914=([org.apache.dubbo.config.annotation.Method], java.lang.Object), var2471_isReturn/-1644516759=([org.apache.dubbo.config.annotation.Method], boolean), var3802_valueOf/1602327315=([boolean], java.lang.Boolean), setReturn/-471685518=([org.apache.dubbo.config.MethodConfig, java.lang.Boolean], void), var2471_oninvoke/1545837869=([org.apache.dubbo.config.annotation.Method], java.lang.String), var2471_onreturn/-1938273931=([org.apache.dubbo.config.annotation.Method], java.lang.String), var2471_onthrow/-2012856209=([org.apache.dubbo.config.annotation.Method], java.lang.String), var2471_arguments/-78858477=([org.apache.dubbo.config.annotation.Method], org.apache.dubbo.config.annotation.Argument[])}
; {var3684=org.apache.dubbo.config.MethodConfig, var3249=r0, var2471=org.apache.dubbo.config.annotation.Method, var345=r1, var18=org.apache.dubbo.config.AbstractMethodConfig, var2174=org.apache.dubbo.config.AbstractConfig, var2914=java.lang.Object, var1325=class "Lorg/apache/dubbo/config/annotation/Method;", var874=$z0, var3802=java.lang.Boolean, var3472=$r2, var71=$r4, var1143=$r3, var1493=$z1, var1558=$r26, var1744=$r27, var1488=$z2, var2571=$r30, var2327=$r31, var782=$z3, var1316=org.apache.dubbo.config.annotation.Argument, var3816=$r34}
; {org.apache.dubbo.config.MethodConfig=var3684, r0=var3249, org.apache.dubbo.config.annotation.Method=var2471, r1=var345, org.apache.dubbo.config.AbstractMethodConfig=var18, org.apache.dubbo.config.AbstractConfig=var2174, java.lang.Object=var2914, class "Lorg/apache/dubbo/config/annotation/Method;"=var1325, $z0=var874, java.lang.Boolean=var3802, $r2=var3472, $r4=var71, $r3=var1143, $z1=var1493, $r26=var1558, $r27=var1744, $z2=var1488, $r30=var2571, $r31=var2327, $z3=var782, org.apache.dubbo.config.annotation.Argument=var1316, $r34=var3816}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 3}
;stmts r0 := @this: org.apache.dubbo.config.MethodConfig;	r1 := @parameter0: org.apache.dubbo.config.annotation.Method;	specialinvoke r0.<org.apache.dubbo.config.AbstractMethodConfig: void <init>()>();	virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: void appendAnnotation(java.lang.Class,java.lang.Object)>(class "Lorg/apache/dubbo/config/annotation/Method;", r1);	$z0 = interfaceinvoke r1.<org.apache.dubbo.config.'annotation'.Method: boolean isReturn()>();	$r2 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>($z0);	virtualinvoke r0.<org.apache.dubbo.config.MethodConfig: void setReturn(java.lang.Boolean)>($r2);	$r4 = "";	$r3 = interfaceinvoke r1.<org.apache.dubbo.config.'annotation'.Method: java.lang.String oninvoke()>();	$z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>($r3);	if $z1 != 0 goto $r26 = "";	$r26 = "";	$r27 = interfaceinvoke r1.<org.apache.dubbo.config.'annotation'.Method: java.lang.String onreturn()>();	$z2 = virtualinvoke $r26.<java.lang.String: boolean equals(java.lang.Object)>($r27);	if $z2 != 0 goto $r30 = "";	$r30 = "";	$r31 = interfaceinvoke r1.<org.apache.dubbo.config.'annotation'.Method: java.lang.String onthrow()>();	$z3 = virtualinvoke $r30.<java.lang.String: boolean equals(java.lang.Object)>($r31);	if $z3 != 0 goto $r34 = interfaceinvoke r1.<org.apache.dubbo.config.'annotation'.Method: org.apache.dubbo.config.'annotation'.Argument[] arguments()>();	$r34 = interfaceinvoke r1.<org.apache.dubbo.config.'annotation'.Method: org.apache.dubbo.config.'annotation'.Argument[] arguments()>();	if $r34 == null goto return;	return
;block_num 5
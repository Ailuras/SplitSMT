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

(declare-sort var2144 0)
(declare-sort var3224 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getProtocol/491749358 (var2144) String)
(declare-fun var3224_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getHost/-1506772130 (var2144) String)
(declare-fun getServiceKey/1456125852 (var2144) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2144 var2144)
(declare-const null-Bool Bool)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var2783 var2144) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2783 null-var2144)))
(declare-const var1776 Bool) ; Statement: z1 := @parameter0: boolean 
(assert (not (= var1776 null-Bool)))
(declare-const var3844 Bool) ; Statement: z6 := @parameter1: boolean 
(assert (not (= var3844 null-Bool)))
(declare-const var3020 Bool) ; Statement: z2 := @parameter2: boolean 
(assert (not (= var3020 null-Bool)))
(declare-const var3827 Bool) ; Statement: z4 := @parameter3: boolean 
(assert (not (= var3827 null-Bool)))
(declare-const var839 (Array Int String)) ; Statement: r4 := @parameter4: java.lang.String[] 
(assert (not (= var839 null-__Array__Int__String__)))
(define-const var2492 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2492)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2492!1 String)
(assert (= var2492!1 ""))
(assert true)
(define-const var3705 String (getProtocol/491749358 var2783)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(define-const var561 Bool (var3224_isNotEmpty/-1251449450 var3705)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var561 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if z1 == 0 goto (branch) 
(assert (= (ite var1776 1 0) 0)) ; Cond: z1 == 0 
 ; Statement: if z2 == 0 goto r11 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>() 
(assert (= (ite var3020 1 0) 0)) ; Cond: z2 == 0 
(assert true)
(define-const var30 String (getHost/-1506772130 var2783)) ; Statement: r11 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>() 
(assert true) ; Non Conditional
(define-const var1161 Bool (var3224_isNotEmpty/-1251449450 var30)) ; Statement: $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r11) 
 ; Statement: if $z3 == 0 goto (branch) 
(assert (= (ite var1161 1 0) 0)) ; Cond: $z3 == 0 
 ; Statement: if z4 == 0 goto r12 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert (not (= (ite var3827 1 0) 0))) ; Negate: Cond: z4 == 0  
(assert true)
(define-const var3587 String (getServiceKey/1456125852 var2783)) ; Statement: r12 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
 ; Statement: goto [?= $z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r12)] 
(assert true) ; Non Conditional
(define-const var1761 Bool (var3224_isNotEmpty/-1251449450 var3587)) ; Statement: $z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r12) 
 ; Statement: if $z5 == 0 goto (branch) 
(assert (= (ite var1761 1 0) 0)) ; Cond: $z5 == 0 
 ; Statement: if z6 == 0 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var3844 1 0) 0)) ; Cond: z6 == 0 
(assert true)
(define-const var3561 String (toString/-2075883882 var2492!1)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r3 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), var3224_isNotEmpty/-1251449450=([java.lang.String], boolean), getHost/-1506772130=([org.apache.dubbo.common.URL], java.lang.String), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2144=org.apache.dubbo.common.URL, var2783=r1, var1776=z1, var3844=z6, var3020=z2, var3827=z4, var839=r4, var2492=$r0, var3705=$r2, var3224=org.apache.dubbo.common.utils.StringUtils, var561=$z0, var30=r11, var1161=$z3, var3587=r12, var1761=$z5, var3561=$r3}
; {org.apache.dubbo.common.URL=var2144, r1=var2783, z1=var1776, z6=var3844, z2=var3020, z4=var3827, r4=var839, $r0=var2492, $r2=var3705, org.apache.dubbo.common.utils.StringUtils=var3224, $z0=var561, r11=var30, $z3=var1161, r12=var3587, $z5=var1761, $r3=var3561}
;seq <java.lang.StringBuilder: void <init>()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	z1 := @parameter0: boolean;	z6 := @parameter1: boolean;	z2 := @parameter2: boolean;	z4 := @parameter3: boolean;	r4 := @parameter4: java.lang.String[];	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2);	if $z0 == 0 goto (branch);	if z1 == 0 goto (branch);	if z2 == 0 goto r11 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>();	r11 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>();	$z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r11);	if $z3 == 0 goto (branch);	if z4 == 0 goto r12 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	r12 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	goto [?= $z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r12)];	$z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r12);	if $z5 == 0 goto (branch);	if z6 == 0 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r3
;block_num 10
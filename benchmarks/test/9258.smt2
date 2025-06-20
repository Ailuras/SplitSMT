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

(declare-sort var515 0)
(declare-sort var183 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getProtocol/491749358 (var515) String)
(declare-fun var183_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getHost/-1506772130 (var515) String)
(declare-fun getPath/898047937 (var515) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var515 var515)
(declare-const null-Bool Bool)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var2863 var515) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2863 null-var515)))
(declare-const var3516 Bool) ; Statement: z1 := @parameter0: boolean 
(assert (not (= var3516 null-Bool)))
(declare-const var2532 Bool) ; Statement: z6 := @parameter1: boolean 
(assert (not (= var2532 null-Bool)))
(declare-const var3085 Bool) ; Statement: z2 := @parameter2: boolean 
(assert (not (= var3085 null-Bool)))
(declare-const var1328 Bool) ; Statement: z4 := @parameter3: boolean 
(assert (not (= var1328 null-Bool)))
(declare-const var2135 (Array Int String)) ; Statement: r4 := @parameter4: java.lang.String[] 
(assert (not (= var2135 null-__Array__Int__String__)))
(define-const var3165 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3165)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3165!1 String)
(assert (= var3165!1 ""))
(assert true)
(define-const var2087 String (getProtocol/491749358 var2863)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(define-const var3259 Bool (var183_isNotEmpty/-1251449450 var2087)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var3259 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if z1 == 0 goto (branch) 
(assert (= (ite var3516 1 0) 0)) ; Cond: z1 == 0 
 ; Statement: if z2 == 0 goto r11 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>() 
(assert (= (ite var3085 1 0) 0)) ; Cond: z2 == 0 
(assert true)
(define-const var2991 String (getHost/-1506772130 var2863)) ; Statement: r11 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>() 
(assert true) ; Non Conditional
(define-const var1166 Bool (var183_isNotEmpty/-1251449450 var2991)) ; Statement: $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r11) 
 ; Statement: if $z3 == 0 goto (branch) 
(assert (= (ite var1166 1 0) 0)) ; Cond: $z3 == 0 
 ; Statement: if z4 == 0 goto r12 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert (= (ite var1328 1 0) 0)) ; Cond: z4 == 0 
(assert true)
(define-const var948 String (getPath/898047937 var2863)) ; Statement: r12 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert true) ; Non Conditional
(define-const var3915 Bool (var183_isNotEmpty/-1251449450 var948)) ; Statement: $z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r12) 
 ; Statement: if $z5 == 0 goto (branch) 
(assert (= (ite var3915 1 0) 0)) ; Cond: $z5 == 0 
 ; Statement: if z6 == 0 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var2532 1 0) 0)) ; Cond: z6 == 0 
(assert true)
(define-const var1459 String (toString/-2075883882 var3165!1)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r3 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), var183_isNotEmpty/-1251449450=([java.lang.String], boolean), getHost/-1506772130=([org.apache.dubbo.common.URL], java.lang.String), getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var515=org.apache.dubbo.common.URL, var2863=r1, var3516=z1, var2532=z6, var3085=z2, var1328=z4, var2135=r4, var3165=$r0, var2087=$r2, var183=org.apache.dubbo.common.utils.StringUtils, var3259=$z0, var2991=r11, var1166=$z3, var948=r12, var3915=$z5, var1459=$r3}
; {org.apache.dubbo.common.URL=var515, r1=var2863, z1=var3516, z6=var2532, z2=var3085, z4=var1328, r4=var2135, $r0=var3165, $r2=var2087, org.apache.dubbo.common.utils.StringUtils=var183, $z0=var3259, r11=var2991, $z3=var1166, r12=var948, $z5=var3915, $r3=var1459}
;seq <java.lang.StringBuilder: void <init>()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	z1 := @parameter0: boolean;	z6 := @parameter1: boolean;	z2 := @parameter2: boolean;	z4 := @parameter3: boolean;	r4 := @parameter4: java.lang.String[];	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2);	if $z0 == 0 goto (branch);	if z1 == 0 goto (branch);	if z2 == 0 goto r11 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>();	r11 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>();	$z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r11);	if $z3 == 0 goto (branch);	if z4 == 0 goto r12 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	r12 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r12);	if $z5 == 0 goto (branch);	if z6 == 0 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r3
;block_num 10
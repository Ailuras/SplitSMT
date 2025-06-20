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

(declare-sort var385 0)
(declare-sort var3659 0)
(declare-sort var1057 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun extension/610238036 (var385) var3659)
(declare-fun append/-1031950772 (String var3659) String)
(declare-fun getPriority/-1724331382 (var385) Int)
(declare-fun getPatterns/-1144871385 (var385) (Array Int String))
(declare-fun var1057_isNotEmpty/-1514399294 ((Array Int var3659)) Bool)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var3659__ ((Array Int String)) (Array Int var3659))
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var385 var385)
(declare-const var3962 var385) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.filter.AbstractRestFilter 
(assert (not (= var3962 null-var385)))
(define-const var3306 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/-1061048412 var3306 "RestFilter{extension=")) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("RestFilter{extension=") 
(declare-const var3306!1 String)
(assert (= var3306!1 "RestFilter{extension="))
(define-const var1895 var3659 (extension/610238036 var3962)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.filter.AbstractRestFilter: java.lang.Object extension> 
(assert true)
;(assert (append/-1031950772 var3306!1 var1895)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var3306!2 String)
(assert (str.prefixof var3306!1 var3306!2))
(assert true)
(define-const var3548 Int (getPriority/-1724331382 var3962)) ; Statement: i0 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.filter.AbstractRestFilter: int getPriority()>() 
 ; Statement: if i0 == 0 goto $r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.filter.AbstractRestFilter: java.lang.String[] getPatterns()>() 
(assert (= var3548 0)) ; Cond: i0 == 0 
(assert true)
(define-const var31 (Array Int String) (getPatterns/-1144871385 var3962)) ; Statement: $r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.filter.AbstractRestFilter: java.lang.String[] getPatterns()>() 
(define-const var3214 Bool (var1057_isNotEmpty/-1514399294 (cast-from-__Array__Int__String__-to-__Array__Int__var3659__ var31))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.ArrayUtils: boolean isNotEmpty(java.lang.Object[])>($r8) 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(assert (= (ite var3214 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2220 String (append/-1166366385 var3306!2 125)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var3306!3 String)
(assert (str.prefixof var3306!2 var3306!3))
(assert true)
(define-const var439 String (toString/-2075883882 var2220)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), extension/610238036=([org.apache.dubbo.rpc.protocol.tri.rest.filter.AbstractRestFilter], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), getPriority/-1724331382=([org.apache.dubbo.rpc.protocol.tri.rest.filter.AbstractRestFilter], int), getPatterns/-1144871385=([org.apache.dubbo.rpc.protocol.tri.rest.filter.AbstractRestFilter], java.lang.String[]), var1057_isNotEmpty/-1514399294=([java.lang.Object[]], boolean), cast-from-__Array__Int__String__-to-__Array__Int__var3659__=([java.lang.String[]], java.lang.Object[]), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var385=org.apache.dubbo.rpc.protocol.tri.rest.filter.AbstractRestFilter, var3962=r1, var3306=$r0, var3659=java.lang.Object, var1895=$r2, var3548=i0, var31=$r8, var1057=org.apache.dubbo.common.utils.ArrayUtils, var3214=$z0, var2220=$r3, var439=$r4}
; {org.apache.dubbo.rpc.protocol.tri.rest.filter.AbstractRestFilter=var385, r1=var3962, $r0=var3306, java.lang.Object=var3659, $r2=var1895, i0=var3548, $r8=var31, org.apache.dubbo.common.utils.ArrayUtils=var1057, $z0=var3214, $r3=var2220, $r4=var439}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.filter.AbstractRestFilter;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("RestFilter{extension=");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.filter.AbstractRestFilter: java.lang.Object extension>;	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	i0 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.filter.AbstractRestFilter: int getPriority()>();	if i0 == 0 goto $r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.filter.AbstractRestFilter: java.lang.String[] getPatterns()>();	$r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.filter.AbstractRestFilter: java.lang.String[] getPatterns()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.ArrayUtils: boolean isNotEmpty(java.lang.Object[])>($r8);	if $z0 == 0 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 3
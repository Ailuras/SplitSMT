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

(declare-sort var1908 0)
(declare-sort var563 0)
(declare-sort var469 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun filter/-143364471 (var1908) var563)
(declare-fun append/-1031950772 (String var469) String)
(declare-fun cast-from-var563-to-var469 (var563) var469)
(declare-fun getPriority/-1506592953 (var1908) Int)
(declare-fun getPatterns/-304904246 (var1908) (Array Int String))
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1908 var1908)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var3941 var1908) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.FilterAdapter$FilterRestFilter 
(assert (not (= var3941 null-var1908)))
(define-const var2021 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/-1061048412 var2021 "RestFilter{filter=")) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("RestFilter{filter=") 
(declare-const var2021!1 String)
(assert (= var2021!1 "RestFilter{filter="))
(define-const var377 var563 (filter/-143364471 var3941)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.FilterAdapter$FilterRestFilter: javax.servlet.Filter filter> 
(assert true)
;(assert (append/-1031950772 var2021!1 (cast-from-var563-to-var469 var377))) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var2021!2 String)
(assert (str.prefixof var2021!1 var2021!2))
(assert true)
(define-const var3300 Int (getPriority/-1506592953 var3941)) ; Statement: i0 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.FilterAdapter$FilterRestFilter: int getPriority()>() 
 ; Statement: if i0 == 0 goto $r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.FilterAdapter$FilterRestFilter: java.lang.String[] getPatterns()>() 
(assert (= var3300 0)) ; Cond: i0 == 0 
(assert true)
(define-const var3776 (Array Int String) (getPatterns/-304904246 var3941)) ; Statement: $r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.FilterAdapter$FilterRestFilter: java.lang.String[] getPatterns()>() 
 ; Statement: if $r8 == null goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(assert (= var3776 null-__Array__Int__String__)) ; Cond: $r8 == null 
(assert true)
(define-const var2371 String (append/-1166366385 var2021!2 125)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var2021!3 String)
(assert (str.prefixof var2021!2 var2021!3))
(assert true)
(define-const var3403 String (toString/-2075883882 var2371)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), filter/-143364471=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.FilterAdapter$FilterRestFilter], javax.servlet.Filter), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var563-to-var469=([javax.servlet.Filter], java.lang.Object), getPriority/-1506592953=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.FilterAdapter$FilterRestFilter], int), getPatterns/-304904246=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.FilterAdapter$FilterRestFilter], java.lang.String[]), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1908=org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.FilterAdapter$FilterRestFilter, var3941=r1, var2021=$r0, var563=javax.servlet.Filter, var377=$r2, var469=java.lang.Object, var3300=i0, var3776=$r8, var2371=$r3, var3403=$r4}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.FilterAdapter$FilterRestFilter=var1908, r1=var3941, $r0=var2021, javax.servlet.Filter=var563, $r2=var377, java.lang.Object=var469, i0=var3300, $r8=var3776, $r3=var2371, $r4=var3403}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.FilterAdapter$FilterRestFilter;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("RestFilter{filter=");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.FilterAdapter$FilterRestFilter: javax.servlet.Filter filter>;	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	i0 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.FilterAdapter$FilterRestFilter: int getPriority()>();	if i0 == 0 goto $r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.FilterAdapter$FilterRestFilter: java.lang.String[] getPatterns()>();	$r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.FilterAdapter$FilterRestFilter: java.lang.String[] getPatterns()>();	if $r8 == null goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 3
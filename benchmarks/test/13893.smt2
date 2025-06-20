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

(declare-sort var967 0)
(declare-sort var2094 0)
(declare-sort var851 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun filter/-1121394299 (var967) var2094)
(declare-fun append/-1031950772 (String var851) String)
(declare-fun cast-from-var2094-to-var851 (var2094) var851)
(declare-fun getPriority/1677119555 (var967) Int)
(declare-fun getPatterns/956520270 (var967) (Array Int String))
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var967 var967)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var3819 var967) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.FilterAdapter$FilterRestFilter 
(assert (not (= var3819 null-var967)))
(define-const var209 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/-1061048412 var209 "RestFilter{filter=")) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("RestFilter{filter=") 
(declare-const var209!1 String)
(assert (= var209!1 "RestFilter{filter="))
(define-const var3139 var2094 (filter/-1121394299 var3819)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.FilterAdapter$FilterRestFilter: jakarta.servlet.Filter filter> 
(assert true)
;(assert (append/-1031950772 var209!1 (cast-from-var2094-to-var851 var3139))) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var209!2 String)
(assert (str.prefixof var209!1 var209!2))
(assert true)
(define-const var541 Int (getPriority/1677119555 var3819)) ; Statement: i0 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.FilterAdapter$FilterRestFilter: int getPriority()>() 
 ; Statement: if i0 == 0 goto $r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.FilterAdapter$FilterRestFilter: java.lang.String[] getPatterns()>() 
(assert (= var541 0)) ; Cond: i0 == 0 
(assert true)
(define-const var2010 (Array Int String) (getPatterns/956520270 var3819)) ; Statement: $r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.FilterAdapter$FilterRestFilter: java.lang.String[] getPatterns()>() 
 ; Statement: if $r8 == null goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(assert (= var2010 null-__Array__Int__String__)) ; Cond: $r8 == null 
(assert true)
(define-const var495 String (append/-1166366385 var209!2 125)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var209!3 String)
(assert (str.prefixof var209!2 var209!3))
(assert true)
(define-const var3079 String (toString/-2075883882 var495)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), filter/-1121394299=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.FilterAdapter$FilterRestFilter], jakarta.servlet.Filter), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2094-to-var851=([jakarta.servlet.Filter], java.lang.Object), getPriority/1677119555=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.FilterAdapter$FilterRestFilter], int), getPatterns/956520270=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.FilterAdapter$FilterRestFilter], java.lang.String[]), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var967=org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.FilterAdapter$FilterRestFilter, var3819=r1, var209=$r0, var2094=jakarta.servlet.Filter, var3139=$r2, var851=java.lang.Object, var541=i0, var2010=$r8, var495=$r3, var3079=$r4}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.FilterAdapter$FilterRestFilter=var967, r1=var3819, $r0=var209, jakarta.servlet.Filter=var2094, $r2=var3139, java.lang.Object=var851, i0=var541, $r8=var2010, $r3=var495, $r4=var3079}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.FilterAdapter$FilterRestFilter;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("RestFilter{filter=");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.FilterAdapter$FilterRestFilter: jakarta.servlet.Filter filter>;	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	i0 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.FilterAdapter$FilterRestFilter: int getPriority()>();	if i0 == 0 goto $r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.FilterAdapter$FilterRestFilter: java.lang.String[] getPatterns()>();	$r8 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.FilterAdapter$FilterRestFilter: java.lang.String[] getPatterns()>();	if $r8 == null goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 3
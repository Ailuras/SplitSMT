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

(declare-sort var333 0)
(declare-sort var1336 0)
(declare-sort var3103 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun var3103_getMethodName/-516674313 (var1336) String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun var1336_getParameterTypes/-2027342342 (var1336) (Array Int ClassObject))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var333 var333)
(declare-const null-var1336 var1336)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const var921 var333) ; Statement: r6 := @this: org.apache.dubbo.rpc.filter.DeprecatedFilter 
(assert (not (= var921 null-var333)))
(declare-const var3220 var1336) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3220 null-var1336)))
(define-const var2344 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(define-const var3052 String (var3103_getMethodName/-516674313 var3220)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r1) 
(assert true)
;(assert (<init>/-1061048412 var2344 var3052)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r2) 
(declare-const var2344!1 String)
(assert (= var2344!1 var3052))
(assert true)
;(assert (append/-1166366385 var2344!1 40)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var2344!2 String)
(assert (str.prefixof var2344!1 var2344!2))
(define-const var3600 (Array Int ClassObject) (var1336_getParameterTypes/-2027342342 var3220)) ; Statement: r3 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invocation: java.lang.Class[] getParameterTypes()>() 
 ; Statement: if r3 == null goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(assert (= var3600 null-__Array__Int__ClassObject__)) ; Cond: r3 == null 
(assert true)
;(assert (append/-1166366385 var2344!2 41)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var2344!3 String)
(assert (str.prefixof var2344!2 var2344!3))
(assert true)
(define-const var2538 String (toString/-2075883882 var2344!3)) ; Statement: $r7 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {String-init=([], java.lang.StringBuilder), var3103_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), var1336_getParameterTypes/-2027342342=([org.apache.dubbo.rpc.Invocation], java.lang.Class[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var333=org.apache.dubbo.rpc.filter.DeprecatedFilter, var921=r6, var1336=org.apache.dubbo.rpc.Invocation, var3220=r1, var2344=$r0, var3103=org.apache.dubbo.rpc.support.RpcUtils, var3052=$r2, var3600=r3, var2538=$r7}
; {org.apache.dubbo.rpc.filter.DeprecatedFilter=var333, r6=var921, org.apache.dubbo.rpc.Invocation=var1336, r1=var3220, $r0=var2344, org.apache.dubbo.rpc.support.RpcUtils=var3103, $r2=var3052, r3=var3600, $r7=var2538}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r6 := @this: org.apache.dubbo.rpc.filter.DeprecatedFilter;	r1 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r0 = new java.lang.StringBuilder;	$r2 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r1);	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r2);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	r3 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invocation: java.lang.Class[] getParameterTypes()>();	if r3 == null goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r7 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 2
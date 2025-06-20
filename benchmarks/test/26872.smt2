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

(declare-sort var1315 0)
(declare-sort var2750 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun name/-1799577674 (var1315) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun required/-1799577674 (var1315) Bool)
(declare-fun defaultValue/-1799577674 (var1315) String)
(declare-fun type/-1799577674 (var1315) ClassObject)
(declare-fun nestedTypes/-1799577674 (var1315) (Array Int ClassObject))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1315 var1315)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const var815 var1315) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta 
(assert (not (= var815 null-var1315)))
(define-const var1234 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/-1061048412 var1234 "NamedValueMeta{name=\u0027")) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("NamedValueMeta{name=\'") 
(declare-const var1234!1 String)
(assert (= var1234!1 "NamedValueMeta{name=\u0027"))
(define-const var2946 String (name/-1799577674 var815)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.String name> 
(assert true)
(define-const var3377 String (append/672562846 var1234!1 var2946)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1234!2 String)
(assert (= var1234!2 (str.++ var1234!1 var2946)))
(assert true)
;(assert (append/-1166366385 var3377 39)) ; Statement: virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var3377!1 String)
(assert (str.prefixof var3377 var3377!1))
(define-const var943 Bool (required/-1799577674 var815)) ; Statement: $z0 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: boolean required> 
 ; Statement: if $z0 == 0 goto $r4 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.String defaultValue> 
(assert (= (ite var943 1 0) 0)) ; Cond: $z0 == 0 
(define-const var811 String (defaultValue/-1799577674 var815)) ; Statement: $r4 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.String defaultValue> 
 ; Statement: if $r4 == null goto $r5 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.Class type> 
(assert (= var811 null-String)) ; Cond: $r4 == null 
(define-const var2836 ClassObject (type/-1799577674 var815)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.Class type> 
 ; Statement: if $r5 == null goto $r19 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.Class[] nestedTypes> 
(assert (= var2836 null-ClassObject)) ; Cond: $r5 == null 
(define-const var1159 (Array Int ClassObject) (nestedTypes/-1799577674 var815)) ; Statement: $r19 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.Class[] nestedTypes> 
 ; Statement: if $r19 == null goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(assert (= var1159 null-__Array__Int__ClassObject__)) ; Cond: $r19 == null 
(assert true)
;(assert (append/-1166366385 var1234!2 125)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var1234!3 String)
(assert (str.prefixof var1234!2 var1234!3))
(assert true)
(define-const var2013 String (toString/-2075883882 var1234!3)) ; Statement: $r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), name/-1799577674=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), required/-1799577674=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta], boolean), defaultValue/-1799577674=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta], java.lang.String), type/-1799577674=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta], java.lang.Class), nestedTypes/-1799577674=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta], java.lang.Class[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1315=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta, var815=r1, var1234=$r0, var2946=$r2, var3377=$r3, var943=$z0, var811=$r4, var2750=null_type, var2836=$r5, var1159=$r19, var2013=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta=var1315, r1=var815, $r0=var1234, $r2=var2946, $r3=var3377, $z0=var943, $r4=var811, null_type=var2750, $r5=var2836, $r19=var1159, $r6=var2013}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("NamedValueMeta{name=\'");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.String name>;	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$z0 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: boolean required>;	if $z0 == 0 goto $r4 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.String defaultValue>;	$r4 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.String defaultValue>;	if $r4 == null goto $r5 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.Class type>;	$r5 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.Class type>;	if $r5 == null goto $r19 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.Class[] nestedTypes>;	$r19 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.Class[] nestedTypes>;	if $r19 == null goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 5
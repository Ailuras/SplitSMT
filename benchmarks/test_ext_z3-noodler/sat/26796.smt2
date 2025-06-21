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

(declare-sort var1044 0)
(declare-sort var2008 0)
(declare-sort var2153 0)
(declare-sort var2460 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2153-init () var2153)
(declare-fun arr-var2460-init () (Array Int var2460))
(declare-fun cast-from-String-to-var2460 (String) var2460)
(declare-fun getAnnotationType/-998790839 (var1044) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun String_format/1339386452 (String (Array Int var2460)) String)
(declare-fun <init>/875830710 (var2153 String) void)
(declare-const null-var1044 var1044)
(declare-const null-String String)
(declare-const null-__Array__Int__var2460__ (Array Int var2460))
(declare-const var2257 var1044) ; Statement: r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta 
(assert (not (= var2257 null-var1044)))
(declare-const var1668 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1668 null-String)))
(define-const var2173 var2153 var2153-init) ; Statement: $r0 = new java.lang.IllegalArgumentException 
(define-const var3750 (Array Int var2460) arr-var2460-init) ; Statement: $r1 = newarray (java.lang.Object)[2] 
(declare-const var3750!1 (Array Int var2460))
(assert (not (= var3750!1 null-__Array__Int__var2460__)))
(assert (= (select var3750!1 0) (cast-from-String-to-var2460 var1668))) ; Statement: $r1[0] = r2 
(assert true)
(define-const var1894 ClassObject (getAnnotationType/-998790839 var2257)) ; Statement: $r4 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.Class getAnnotationType()>() 
(assert true)
(define-const var2874 String (getName/-1958580599 var1894)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.Class: java.lang.String getName()>() 
(declare-const var3750!2 (Array Int var2460))
(assert (not (= var3750!2 null-__Array__Int__var2460__)))
(assert (= (select var3750!2 1) (cast-from-String-to-var2460 var2874))) ; Statement: $r1[1] = $r5 
(define-const var3605 String (String_format/1339386452 "Attribute \u0027%s\u0027 not found in attributes for annotation [%s]" var3750!2)) ; Statement: $r6 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Attribute \'%s\' not found in attributes for annotation [%s]", $r1) 
(assert true)
;(assert (<init>/875830710 var2173 var3605)) ; Statement: specialinvoke $r0.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r6) 

(declare-const var2173!1 var2153)
(declare-const var3605!1 String)
 ; Statement: return $r0 
(check-sat)
; {var2153-init=([], java.lang.IllegalArgumentException), arr-var2460-init=([], java.lang.Object[]), cast-from-String-to-var2460=([java.lang.String], java.lang.Object), getAnnotationType/-998790839=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var1044=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta, var2257=r3, var1668=r2, var2008=null_type, var2153=java.lang.IllegalArgumentException, var2173=$r0, var2460=java.lang.Object, var3750=$r1, var1894=$r4, var2874=$r5, var3605=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta=var1044, r3=var2257, r2=var1668, null_type=var2008, java.lang.IllegalArgumentException=var2153, $r0=var2173, java.lang.Object=var2460, $r1=var3750, $r4=var1894, $r5=var2874, $r6=var3605}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta;	r2 := @parameter0: java.lang.String;	$r0 = new java.lang.IllegalArgumentException;	$r1 = newarray (java.lang.Object)[2];	$r1[0] = r2;	$r4 = virtualinvoke r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.Class getAnnotationType()>();	$r5 = virtualinvoke $r4.<java.lang.Class: java.lang.String getName()>();	$r1[1] = $r5;	$r6 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Attribute \'%s\' not found in attributes for annotation [%s]", $r1);	specialinvoke $r0.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r6);	return $r0
;block_num 1
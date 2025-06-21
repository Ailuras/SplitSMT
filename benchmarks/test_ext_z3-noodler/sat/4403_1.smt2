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

(declare-sort var2456 0)
(declare-sort var2035 0)
(declare-sort var3326 0)
(declare-sort var21 0)
(declare-sort var867 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3326_iterator/-912451715 (var3326) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun var21-init () var21)
(declare-fun arr-var867-init () (Array Int var867))
(declare-fun cast-from-var3326-to-var867 (var3326) var867)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun cast-from-String-to-var867 (String) var867)
(declare-fun String_format/1339386452 (String (Array Int var867)) String)
(declare-fun <init>/875830710 (var21 String) void)
(declare-const null-var2456 var2456)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2035 var2035)
(declare-const var2456-SERVICE_ANNOTATION_CLASSES var3326)
(declare-const null-__Array__Int__var867__ (Array Int var867))
(declare-const var2430 var2456) ; Statement: r10 := @this: org.apache.dubbo.common.utils.ServiceAnnotationResolver 
(assert (not (= var2430 null-var2456)))
(declare-const var1781 ClassObject) ; Statement: r5 := @parameter0: java.lang.Class 
(assert (not (= var1781 null-ClassObject)))
(define-const var3877 var2035 null-var2035) ; Statement: r11 = null 
(define-const var519 var3326 var2456-SERVICE_ANNOTATION_CLASSES) ; Statement: $r0 = <org.apache.dubbo.common.utils.ServiceAnnotationResolver: java.util.List SERVICE_ANNOTATION_CLASSES> 
(define-const var2503 Iterator (var3326_iterator/-912451715 var519)) ; Statement: r1 = interfaceinvoke $r0.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var637 Bool (Iterator_hasNext/-1669924200 var2503)) ; Statement: $z0 = interfaceinvoke r1.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var637 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if r11 != null goto return r11 
(assert (not (not (= var3877 null-var2035)))) ; Negate: Cond: r11 != null  
(define-const var1586 var21 var21-init) ; Statement: $r2 = new java.lang.IllegalArgumentException 
(define-const var3924 (Array Int var867) arr-var867-init) ; Statement: $r3 = newarray (java.lang.Object)[2] 
(define-const var3463 var3326 var2456-SERVICE_ANNOTATION_CLASSES) ; Statement: $r4 = <org.apache.dubbo.common.utils.ServiceAnnotationResolver: java.util.List SERVICE_ANNOTATION_CLASSES> 
(declare-const var3924!1 (Array Int var867))
(assert (not (= var3924!1 null-__Array__Int__var867__)))
(assert (= (select var3924!1 0) (cast-from-var3326-to-var867 var3463))) ; Statement: $r3[0] = $r4 
(assert true)
(define-const var1932 String (getName/-1958580599 var1781)) ; Statement: $r6 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>() 
(declare-const var3924!2 (Array Int var867))
(assert (not (= var3924!2 null-__Array__Int__var867__)))
(assert (= (select var3924!2 1) (cast-from-String-to-var867 var1932))) ; Statement: $r3[1] = $r6 
(define-const var558 String (String_format/1339386452 "Any annotation of [%s] can\u0027t be annotated in the service type[%s]." var3924!2)) ; Statement: $r7 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Any annotation of [%s] can\'t be annotated in the service type[%s].", $r3) 
(assert true)
;(assert (<init>/875830710 var1586 var558)) ; Statement: specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r7) 

(declare-const var1586!1 var21)
(declare-const var558!1 String)
 ; Statement: throw $r2 
(check-sat)
; {var3326_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), var21-init=([], java.lang.IllegalArgumentException), arr-var867-init=([], java.lang.Object[]), cast-from-var3326-to-var867=([java.util.List], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), cast-from-String-to-var867=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var2456=org.apache.dubbo.common.utils.ServiceAnnotationResolver, var2430=r10, var1781=r5, var2035=java.lang.annotation.Annotation, var3877=r11, var3326=java.util.List, var519=$r0, var2503=r1, var637=$z0, var21=java.lang.IllegalArgumentException, var1586=$r2, var867=java.lang.Object, var3924=$r3, var3463=$r4, var1932=$r6, var558=$r7}
; {org.apache.dubbo.common.utils.ServiceAnnotationResolver=var2456, r10=var2430, r5=var1781, java.lang.annotation.Annotation=var2035, r11=var3877, java.util.List=var3326, $r0=var519, r1=var2503, $z0=var637, java.lang.IllegalArgumentException=var21, $r2=var1586, java.lang.Object=var867, $r3=var3924, $r4=var3463, $r6=var1932, $r7=var558}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r10 := @this: org.apache.dubbo.common.utils.ServiceAnnotationResolver;	r5 := @parameter0: java.lang.Class;	r11 = null;	$r0 = <org.apache.dubbo.common.utils.ServiceAnnotationResolver: java.util.List SERVICE_ANNOTATION_CLASSES>;	r1 = interfaceinvoke $r0.<java.util.List: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r1.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto (branch);	if r11 != null goto return r11;	$r2 = new java.lang.IllegalArgumentException;	$r3 = newarray (java.lang.Object)[2];	$r4 = <org.apache.dubbo.common.utils.ServiceAnnotationResolver: java.util.List SERVICE_ANNOTATION_CLASSES>;	$r3[0] = $r4;	$r6 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>();	$r3[1] = $r6;	$r7 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Any annotation of [%s] can\'t be annotated in the service type[%s].", $r3);	specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r7);	throw $r2
;block_num 4
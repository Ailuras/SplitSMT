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

(declare-sort var1753 0)
(declare-sort var709 0)
(declare-sort var3099 0)
(declare-sort var167 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getConstructors/-1160885883 (ClassObject) (Array Int var3099))
(declare-fun getLength-Arr-var3099-1 ((Array Int var3099)) Int)
(declare-fun var167-init () var167)
(declare-fun <init>/1412640790 (var167 var1753 String var3099) void)
(declare-const null-var1753 var1753)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const null-var3099 var3099)
(declare-const var3282 var1753) ; Statement: r4 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.util.RestToolKit 
(assert (not (= var3282 null-var1753)))
(declare-const var3389 String) ; Statement: r5 := @parameter1: java.lang.String 
(assert (not (= var3389 null-String)))
(declare-const var434 ClassObject) ; Statement: r0 := @parameter2: java.lang.Class 
(assert (not (= var434 null-ClassObject)))
(assert true)
(define-const var865 (Array Int var3099) (getConstructors/-1160885883 var434)) ; Statement: r1 = virtualinvoke r0.<java.lang.Class: java.lang.reflect.Constructor[] getConstructors()>() 
(define-const var1557 var3099 null-var3099) ; Statement: r12 = null 
(define-const var3834 Int (getLength-Arr-var3099-1 var865)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 != 1 goto $r2 = newarray (java.lang.Class)[0] 
(assert (not (not (= var3834 1)))) ; Negate: Cond: $i0 != 1  
(define-const var1557!1 var3099 (select var865 0)) ; Statement: r12 = r1[0] 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if r12 != null goto $r3 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$ConstructorMeta 
(assert (not (= var1557!1 null-var3099))) ; Cond: r12 != null 
(define-const var3816 var167 var167-init) ; Statement: $r3 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$ConstructorMeta 
(assert true)
;(assert (<init>/1412640790 var3816 var3282 var3389 var1557!1)) ; Statement: specialinvoke $r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$ConstructorMeta: void <init>(org.apache.dubbo.rpc.protocol.tri.rest.util.RestToolKit,java.lang.String,java.lang.reflect.Constructor)>(r4, r5, r12) 

(declare-const var3816!1 var167)
(declare-const var3282!1 var1753)
(declare-const var3389!1 String)
(declare-const var1557!2 var3099)
 ; Statement: return $r3 
(check-sat)
; {getConstructors/-1160885883=([java.lang.Class], java.lang.reflect.Constructor[]), getLength-Arr-var3099-1=([java.lang.reflect.Constructor[]], int), var167-init=([], org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$ConstructorMeta), <init>/1412640790=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$ConstructorMeta, org.apache.dubbo.rpc.protocol.tri.rest.util.RestToolKit, java.lang.String, java.lang.reflect.Constructor], void)}
; {var1753=org.apache.dubbo.rpc.protocol.tri.rest.util.RestToolKit, var3282=r4, var3389=r5, var709=null_type, var434=r0, var3099=java.lang.reflect.Constructor, var865=r1, var1557=r12, var3834=$i0, var167=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$ConstructorMeta, var3816=$r3}
; {org.apache.dubbo.rpc.protocol.tri.rest.util.RestToolKit=var1753, r4=var3282, r5=var3389, null_type=var709, r0=var434, java.lang.reflect.Constructor=var3099, r1=var865, r12=var1557, $i0=var3834, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$ConstructorMeta=var167, $r3=var3816}
;seq 
;cnt {}
;stmts r4 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.util.RestToolKit;	r5 := @parameter1: java.lang.String;	r0 := @parameter2: java.lang.Class;	r1 = virtualinvoke r0.<java.lang.Class: java.lang.reflect.Constructor[] getConstructors()>();	r12 = null;	$i0 = lengthof r1;	if $i0 != 1 goto $r2 = newarray (java.lang.Class)[0];	r12 = r1[0];	goto [?= (branch)];	if r12 != null goto $r3 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$ConstructorMeta;	$r3 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$ConstructorMeta;	specialinvoke $r3.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$ConstructorMeta: void <init>(org.apache.dubbo.rpc.protocol.tri.rest.util.RestToolKit,java.lang.String,java.lang.reflect.Constructor)>(r4, r5, r12);	return $r3
;block_num 4
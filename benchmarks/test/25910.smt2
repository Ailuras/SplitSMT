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

(declare-sort var3638 0)
(declare-sort var3738 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun genericType/955514290 (var3638) ClassObject)
(define-fun cast-from-ClassObject-to-ClassObject ((arg ClassObject)) ClassObject arg)
(declare-fun type/955514290 (var3638) ClassObject)
(declare-fun append/-1031950772 (String var3738) String)
(declare-fun cast-from-ClassObject-to-var3738 (ClassObject) var3738)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3638 var3638)
(declare-const null-ClassObject ClassObject)
(declare-const var1472 var3638) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta 
(assert (not (= var1472 null-var3638)))
(define-const var3002 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3002)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3002!1 String)
(assert (= var3002!1 ""))
(assert true)
(define-const var2104 String (append/672562846 var3002!1 "NestedParameter{")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("NestedParameter{") 
(declare-const var3002!2 String)
(assert (= var3002!2 (str.++ var3002!1 "NestedParameter{")))
(define-const var85 ClassObject (genericType/955514290 var1472)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta: java.lang.reflect.Type genericType> 
 ; Statement: if $r2 != null goto $r7 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta: java.lang.reflect.Type genericType> 
(assert (not (not (= var85 null-ClassObject)))) ; Negate: Cond: $r2 != null  
(define-const var2635 ClassObject (cast-from-ClassObject-to-ClassObject (type/955514290 var1472))) ; Statement: $r7 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta: java.lang.Class type> 
 ; Statement: goto [?= $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r7)] 
(assert true) ; Non Conditional
(assert true)
(define-const var1854 String (append/-1031950772 var2104 (cast-from-ClassObject-to-var3738 var2635))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r7) 
(declare-const var2104!1 String)
(assert (str.prefixof var2104 var2104!1))
(assert true)
(define-const var936 String (append/-1166366385 var1854 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var1854!1 String)
(assert (str.prefixof var1854 var1854!1))
(assert true)
(define-const var3583 String (toString/-2075883882 var936)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), genericType/955514290=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta], java.lang.reflect.Type), cast-from-ClassObject-to-ClassObject=([java.lang.Class], java.lang.reflect.Type), type/955514290=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta], java.lang.Class), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var3738=([java.lang.reflect.Type], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3638=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta, var1472=r1, var3002=$r0, var2104=$r3, var85=$r2, var2635=$r7, var3738=java.lang.Object, var1854=$r4, var936=$r5, var3583=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta=var3638, r1=var1472, $r0=var3002, $r3=var2104, $r2=var85, $r7=var2635, java.lang.Object=var3738, $r4=var1854, $r5=var936, $r6=var3583}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("NestedParameter{");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta: java.lang.reflect.Type genericType>;	if $r2 != null goto $r7 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta: java.lang.reflect.Type genericType>;	$r7 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$NestedMeta: java.lang.Class type>;	goto [?= $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r7)];	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r7);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 3
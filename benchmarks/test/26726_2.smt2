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

(declare-sort var3374 0)
(declare-sort var970 0)
(declare-sort var1895 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3374_readObject/-1178792251 (var3374) var970)
(declare-fun var1895-init () var1895)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getClass/1258963082 (var970) ClassObject)
(declare-fun append/-1031950772 (String var970) String)
(declare-fun cast-from-ClassObject-to-var970 (ClassObject) var970)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1557872005 (var1895 String) void)
(declare-const null-var3374 var3374)
(declare-const var1516 var3374) ; Statement: r0 := @this: org.apache.dubbo.common.serialize.ObjectInput 
(assert (not (= var1516 null-var3374)))
(define-const var385 var970 (var3374_readObject/-1178792251 var1516)) ; Statement: r1 = interfaceinvoke r0.<org.apache.dubbo.common.serialize.ObjectInput: java.lang.Object readObject()>() 
(define-const var2948 Bool false) ; Statement: $z0 = r1 instanceof java.lang.Throwable 
 ; Statement: if $z0 != 0 goto $r2 = (java.lang.Throwable) r1 
(assert (not (not (= (ite var2948 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var1485 var1895 var1895-init) ; Statement: $r3 = new java.io.IOException 
(define-const var888 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var888)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var888!1 String)
(assert (= var888!1 ""))
(assert true)
(define-const var1068 String (append/672562846 var888!1 "Response data error, expect Throwable, but get ")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Response data error, expect Throwable, but get ") 
(declare-const var888!2 String)
(assert (= var888!2 (str.++ var888!1 "Response data error, expect Throwable, but get ")))
(assert true)
(define-const var1104 ClassObject (getClass/1258963082 var385)) ; Statement: $r5 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var3560 String (append/-1031950772 var1068 (cast-from-ClassObject-to-var970 var1104))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var1068!1 String)
(assert (str.prefixof var1068 var1068!1))
(assert true)
(define-const var1792 String (toString/-2075883882 var3560)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1557872005 var1485 var1792)) ; Statement: specialinvoke $r3.<java.io.IOException: void <init>(java.lang.String)>($r8) 

(declare-const var1485!1 var1895)
(declare-const var1792!1 String)
 ; Statement: throw $r3 
(check-sat)
; {var3374_readObject/-1178792251=([org.apache.dubbo.common.serialize.ObjectInput], java.lang.Object), var1895-init=([], java.io.IOException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getClass/1258963082=([java.lang.Object], java.lang.Class), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var970=([java.lang.Class], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1557872005=([java.io.IOException, java.lang.String], void)}
; {var3374=org.apache.dubbo.common.serialize.ObjectInput, var1516=r0, var970=java.lang.Object, var385=r1, var2948=$z0, var1895=java.io.IOException, var1485=$r3, var888=$r4, var1068=$r6, var1104=$r5, var3560=$r7, var1792=$r8}
; {org.apache.dubbo.common.serialize.ObjectInput=var3374, r0=var1516, java.lang.Object=var970, r1=var385, $z0=var2948, java.io.IOException=var1895, $r3=var1485, $r4=var888, $r6=var1068, $r5=var1104, $r7=var3560, $r8=var1792}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.serialize.ObjectInput;	r1 = interfaceinvoke r0.<org.apache.dubbo.common.serialize.ObjectInput: java.lang.Object readObject()>();	$z0 = r1 instanceof java.lang.Throwable;	if $z0 != 0 goto $r2 = (java.lang.Throwable) r1;	$r3 = new java.io.IOException;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Response data error, expect Throwable, but get ");	$r5 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r3.<java.io.IOException: void <init>(java.lang.String)>($r8);	throw $r3
;block_num 2
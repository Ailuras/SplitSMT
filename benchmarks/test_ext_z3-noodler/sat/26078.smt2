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

(declare-sort var580 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun group/-834902672 (var580) String)
(declare-fun version/-834902672 (var580) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var580 var580)
(declare-const var2412 var580) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ServiceGroupVersionCondition 
(assert (not (= var2412 null-var580)))
(define-const var796 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var796)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var796!1 String)
(assert (= var796!1 ""))
(assert true)
(define-const var1690 String (append/672562846 var796!1 "ServiceVersionCondition{group=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ServiceVersionCondition{group=\'") 
(declare-const var796!2 String)
(assert (= var796!2 (str.++ var796!1 "ServiceVersionCondition{group=\u0027")))
(define-const var2291 String (group/-834902672 var2412)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ServiceGroupVersionCondition: java.lang.String group> 
(assert true)
(define-const var2635 String (append/672562846 var1690 var2291)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1690!1 String)
(assert (= var1690!1 (str.++ var1690 var2291)))
(assert true)
(define-const var3023 String (append/672562846 var2635 "\u0027, version=\u0027")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\', version=\'") 
(declare-const var2635!1 String)
(assert (= var2635!1 (str.++ var2635 "\u0027, version=\u0027")))
(define-const var1248 String (version/-834902672 var2412)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ServiceGroupVersionCondition: java.lang.String version> 
(assert true)
(define-const var519 String (append/672562846 var3023 var1248)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var3023!1 String)
(assert (= var3023!1 (str.++ var3023 var1248)))
(assert true)
(define-const var328 String (append/672562846 var519 "\u0027}")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\'}") 
(declare-const var519!1 String)
(assert (= var519!1 (str.++ var519 "\u0027}")))
(assert true)
(define-const var1041 String (toString/-2075883882 var328)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), group/-834902672=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ServiceGroupVersionCondition], java.lang.String), version/-834902672=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ServiceGroupVersionCondition], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var580=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ServiceGroupVersionCondition, var2412=r1, var796=$r0, var1690=$r3, var2291=$r2, var2635=$r4, var3023=$r6, var1248=$r5, var519=$r7, var328=$r8, var1041=$r9}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ServiceGroupVersionCondition=var580, r1=var2412, $r0=var796, $r3=var1690, $r2=var2291, $r4=var2635, $r6=var3023, $r5=var1248, $r7=var519, $r8=var328, $r9=var1041}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ServiceGroupVersionCondition;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ServiceVersionCondition{group=\'");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ServiceGroupVersionCondition: java.lang.String group>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\', version=\'");	$r5 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ServiceGroupVersionCondition: java.lang.String version>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\'}");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1
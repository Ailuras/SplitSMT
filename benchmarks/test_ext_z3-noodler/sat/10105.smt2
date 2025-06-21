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

(declare-sort var2198 0)
(declare-sort var3911 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3911-init () var3911)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1084991535 (var3911 String) void)
(declare-const null-var2198 var2198)
(declare-const null-Int Int)
(declare-const var1551 var2198) ; Statement: r0 := @this: org.apache.dubbo.metadata.ServiceInfoV2$Builder 
(assert (not (= var1551 null-var2198)))
(declare-const var1390 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var1390 null-Int)))
 ; Statement: lookupswitch(i0) {     case 7: goto $r1 = specialinvoke r0.<org.apache.dubbo.metadata.ServiceInfoV2$Builder: com.google.protobuf.MapField internalGetMutableParams()>();     default: goto $r2 = new java.lang.RuntimeException; } 
(assert (and (not (= var1390 7)) true)) ; Intersect: Negate: Cond: i0 == 7   and Non Conditional 
(define-const var2667 var3911 var3911-init) ; Statement: $r2 = new java.lang.RuntimeException 
(define-const var2821 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2821)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2821!1 String)
(assert (= var2821!1 ""))
(assert true)
(define-const var487 String (append/672562846 var2821!1 "Invalid map field number: ")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid map field number: ") 
(declare-const var2821!2 String)
(assert (= var2821!2 (str.++ var2821!1 "Invalid map field number: ")))
(assert true)
(define-const var631 String (append/-1001720160 var487 var1390)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var487!1 String)
(assert (str.prefixof var487 var487!1))
(assert true)
(define-const var3327 String (toString/-2075883882 var631)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1084991535 var2667 var3327)) ; Statement: specialinvoke $r2.<java.lang.RuntimeException: void <init>(java.lang.String)>($r6) 

(declare-const var2667!1 var3911)
(declare-const var3327!1 String)
 ; Statement: throw $r2 
(check-sat)
; {var3911-init=([], java.lang.RuntimeException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1084991535=([java.lang.RuntimeException, java.lang.String], void)}
; {var2198=org.apache.dubbo.metadata.ServiceInfoV2$Builder, var1551=r0, var1390=i0, var3911=java.lang.RuntimeException, var2667=$r2, var2821=$r3, var487=$r4, var631=$r5, var3327=$r6}
; {org.apache.dubbo.metadata.ServiceInfoV2$Builder=var2198, r0=var1551, i0=var1390, java.lang.RuntimeException=var3911, $r2=var2667, $r3=var2821, $r4=var487, $r5=var631, $r6=var3327}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.ServiceInfoV2$Builder;	i0 := @parameter0: int;	lookupswitch(i0) {     case 7: goto $r1 = specialinvoke r0.<org.apache.dubbo.metadata.ServiceInfoV2$Builder: com.google.protobuf.MapField internalGetMutableParams()>();     default: goto $r2 = new java.lang.RuntimeException; };	$r2 = new java.lang.RuntimeException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid map field number: ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.lang.RuntimeException: void <init>(java.lang.String)>($r6);	throw $r2
;block_num 2
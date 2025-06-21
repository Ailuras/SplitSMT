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

(declare-sort var3681 0)
(declare-sort var617 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var617-init () var617)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1084991535 (var617 String) void)
(declare-const null-var3681 var3681)
(declare-const null-Int Int)
(declare-const var3832 var3681) ; Statement: r0 := @this: org.apache.dubbo.metadata.ServiceInfoV2 
(assert (not (= var3832 null-var3681)))
(declare-const var1642 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var1642 null-Int)))
 ; Statement: lookupswitch(i0) {     case 7: goto $r1 = specialinvoke r0.<org.apache.dubbo.metadata.ServiceInfoV2: com.google.protobuf.MapField internalGetParams()>();     default: goto $r2 = new java.lang.RuntimeException; } 
(assert (and (not (= var1642 7)) true)) ; Intersect: Negate: Cond: i0 == 7   and Non Conditional 
(define-const var526 var617 var617-init) ; Statement: $r2 = new java.lang.RuntimeException 
(define-const var1530 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1530)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1530!1 String)
(assert (= var1530!1 ""))
(assert true)
(define-const var1586 String (append/672562846 var1530!1 "Invalid map field number: ")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid map field number: ") 
(declare-const var1530!2 String)
(assert (= var1530!2 (str.++ var1530!1 "Invalid map field number: ")))
(assert true)
(define-const var1625 String (append/-1001720160 var1586 var1642)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var1586!1 String)
(assert (str.prefixof var1586 var1586!1))
(assert true)
(define-const var3967 String (toString/-2075883882 var1625)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1084991535 var526 var3967)) ; Statement: specialinvoke $r2.<java.lang.RuntimeException: void <init>(java.lang.String)>($r6) 

(declare-const var526!1 var617)
(declare-const var3967!1 String)
 ; Statement: throw $r2 
(check-sat)
; {var617-init=([], java.lang.RuntimeException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1084991535=([java.lang.RuntimeException, java.lang.String], void)}
; {var3681=org.apache.dubbo.metadata.ServiceInfoV2, var3832=r0, var1642=i0, var617=java.lang.RuntimeException, var526=$r2, var1530=$r3, var1586=$r4, var1625=$r5, var3967=$r6}
; {org.apache.dubbo.metadata.ServiceInfoV2=var3681, r0=var3832, i0=var1642, java.lang.RuntimeException=var617, $r2=var526, $r3=var1530, $r4=var1586, $r5=var1625, $r6=var3967}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.ServiceInfoV2;	i0 := @parameter0: int;	lookupswitch(i0) {     case 7: goto $r1 = specialinvoke r0.<org.apache.dubbo.metadata.ServiceInfoV2: com.google.protobuf.MapField internalGetParams()>();     default: goto $r2 = new java.lang.RuntimeException; };	$r2 = new java.lang.RuntimeException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid map field number: ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.lang.RuntimeException: void <init>(java.lang.String)>($r6);	throw $r2
;block_num 2
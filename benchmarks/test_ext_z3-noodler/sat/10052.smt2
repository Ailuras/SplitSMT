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

(declare-sort var1222 0)
(declare-sort var3769 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3769-init () var3769)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1084991535 (var3769 String) void)
(declare-const null-var1222 var1222)
(declare-const null-Int Int)
(declare-const var3128 var1222) ; Statement: r0 := @this: org.apache.dubbo.metadata.MetadataInfoV2 
(assert (not (= var3128 null-var1222)))
(declare-const var2693 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var2693 null-Int)))
 ; Statement: lookupswitch(i0) {     case 3: goto $r1 = specialinvoke r0.<org.apache.dubbo.metadata.MetadataInfoV2: com.google.protobuf.MapField internalGetServices()>();     default: goto $r2 = new java.lang.RuntimeException; } 
(assert (and (not (= var2693 3)) true)) ; Intersect: Negate: Cond: i0 == 3   and Non Conditional 
(define-const var3451 var3769 var3769-init) ; Statement: $r2 = new java.lang.RuntimeException 
(define-const var1825 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1825)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1825!1 String)
(assert (= var1825!1 ""))
(assert true)
(define-const var1610 String (append/672562846 var1825!1 "Invalid map field number: ")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid map field number: ") 
(declare-const var1825!2 String)
(assert (= var1825!2 (str.++ var1825!1 "Invalid map field number: ")))
(assert true)
(define-const var3450 String (append/-1001720160 var1610 var2693)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var1610!1 String)
(assert (str.prefixof var1610 var1610!1))
(assert true)
(define-const var336 String (toString/-2075883882 var3450)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1084991535 var3451 var336)) ; Statement: specialinvoke $r2.<java.lang.RuntimeException: void <init>(java.lang.String)>($r6) 

(declare-const var3451!1 var3769)
(declare-const var336!1 String)
 ; Statement: throw $r2 
(check-sat)
; {var3769-init=([], java.lang.RuntimeException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1084991535=([java.lang.RuntimeException, java.lang.String], void)}
; {var1222=org.apache.dubbo.metadata.MetadataInfoV2, var3128=r0, var2693=i0, var3769=java.lang.RuntimeException, var3451=$r2, var1825=$r3, var1610=$r4, var3450=$r5, var336=$r6}
; {org.apache.dubbo.metadata.MetadataInfoV2=var1222, r0=var3128, i0=var2693, java.lang.RuntimeException=var3769, $r2=var3451, $r3=var1825, $r4=var1610, $r5=var3450, $r6=var336}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.MetadataInfoV2;	i0 := @parameter0: int;	lookupswitch(i0) {     case 3: goto $r1 = specialinvoke r0.<org.apache.dubbo.metadata.MetadataInfoV2: com.google.protobuf.MapField internalGetServices()>();     default: goto $r2 = new java.lang.RuntimeException; };	$r2 = new java.lang.RuntimeException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid map field number: ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.lang.RuntimeException: void <init>(java.lang.String)>($r6);	throw $r2
;block_num 2
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

(declare-sort var3977 0)
(declare-sort var1555 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1555-init () var1555)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1084991535 (var1555 String) void)
(declare-const null-var3977 var3977)
(declare-const null-Int Int)
(declare-const var3646 var3977) ; Statement: r0 := @this: org.apache.dubbo.metadata.MetadataInfoV2$Builder 
(assert (not (= var3646 null-var3977)))
(declare-const var1681 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var1681 null-Int)))
 ; Statement: lookupswitch(i0) {     case 3: goto $r1 = specialinvoke r0.<org.apache.dubbo.metadata.MetadataInfoV2$Builder: com.google.protobuf.MapField internalGetMutableServices()>();     default: goto $r2 = new java.lang.RuntimeException; } 
(assert (and (not (= var1681 3)) true)) ; Intersect: Negate: Cond: i0 == 3   and Non Conditional 
(define-const var900 var1555 var1555-init) ; Statement: $r2 = new java.lang.RuntimeException 
(define-const var3138 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3138)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3138!1 String)
(assert (= var3138!1 ""))
(assert true)
(define-const var3478 String (append/672562846 var3138!1 "Invalid map field number: ")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid map field number: ") 
(declare-const var3138!2 String)
(assert (= var3138!2 (str.++ var3138!1 "Invalid map field number: ")))
(assert true)
(define-const var1718 String (append/-1001720160 var3478 var1681)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var3478!1 String)
(assert (str.prefixof var3478 var3478!1))
(assert true)
(define-const var1522 String (toString/-2075883882 var1718)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1084991535 var900 var1522)) ; Statement: specialinvoke $r2.<java.lang.RuntimeException: void <init>(java.lang.String)>($r6) 

(declare-const var900!1 var1555)
(declare-const var1522!1 String)
 ; Statement: throw $r2 
(check-sat)
; {var1555-init=([], java.lang.RuntimeException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1084991535=([java.lang.RuntimeException, java.lang.String], void)}
; {var3977=org.apache.dubbo.metadata.MetadataInfoV2$Builder, var3646=r0, var1681=i0, var1555=java.lang.RuntimeException, var900=$r2, var3138=$r3, var3478=$r4, var1718=$r5, var1522=$r6}
; {org.apache.dubbo.metadata.MetadataInfoV2$Builder=var3977, r0=var3646, i0=var1681, java.lang.RuntimeException=var1555, $r2=var900, $r3=var3138, $r4=var3478, $r5=var1718, $r6=var1522}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.MetadataInfoV2$Builder;	i0 := @parameter0: int;	lookupswitch(i0) {     case 3: goto $r1 = specialinvoke r0.<org.apache.dubbo.metadata.MetadataInfoV2$Builder: com.google.protobuf.MapField internalGetMutableServices()>();     default: goto $r2 = new java.lang.RuntimeException; };	$r2 = new java.lang.RuntimeException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid map field number: ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.lang.RuntimeException: void <init>(java.lang.String)>($r6);	throw $r2
;block_num 2
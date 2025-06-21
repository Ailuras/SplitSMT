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

(declare-sort var469 0)
(declare-sort var2085 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2085-init () var2085)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1084991535 (var2085 String) void)
(declare-const null-var469 var469)
(declare-const null-Int Int)
(declare-const var321 var469) ; Statement: r0 := @this: com.google.rpc.ErrorInfo$Builder 
(assert (not (= var321 null-var469)))
(declare-const var1114 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var1114 null-Int)))
 ; Statement: lookupswitch(i0) {     case 3: goto $r1 = specialinvoke r0.<com.google.rpc.ErrorInfo$Builder: com.google.protobuf.MapField internalGetMutableMetadata()>();     default: goto $r8 = new java.lang.RuntimeException; } 
(assert (and (not (= var1114 3)) true)) ; Intersect: Negate: Cond: i0 == 3   and Non Conditional 
(define-const var61 var2085 var2085-init) ; Statement: $r8 = new java.lang.RuntimeException 
(define-const var3747 String String-init) ; Statement: $r7 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3747)) ; Statement: specialinvoke $r7.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3747!1 String)
(assert (= var3747!1 ""))
(assert true)
(define-const var2117 String (append/672562846 var3747!1 "Invalid map field number: ")) ; Statement: $r4 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid map field number: ") 
(declare-const var3747!2 String)
(assert (= var3747!2 (str.++ var3747!1 "Invalid map field number: ")))
(assert true)
(define-const var3233 String (append/-1001720160 var2117 var1114)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var2117!1 String)
(assert (str.prefixof var2117 var2117!1))
(assert true)
(define-const var3043 String (toString/-2075883882 var3233)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1084991535 var61 var3043)) ; Statement: specialinvoke $r8.<java.lang.RuntimeException: void <init>(java.lang.String)>($r6) 

(declare-const var61!1 var2085)
(declare-const var3043!1 String)
 ; Statement: throw $r8 
(check-sat)
; {var2085-init=([], java.lang.RuntimeException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1084991535=([java.lang.RuntimeException, java.lang.String], void)}
; {var469=com.google.rpc.ErrorInfo$Builder, var321=r0, var1114=i0, var2085=java.lang.RuntimeException, var61=$r8, var3747=$r7, var2117=$r4, var3233=$r5, var3043=$r6}
; {com.google.rpc.ErrorInfo$Builder=var469, r0=var321, i0=var1114, java.lang.RuntimeException=var2085, $r8=var61, $r7=var3747, $r4=var2117, $r5=var3233, $r6=var3043}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: com.google.rpc.ErrorInfo$Builder;	i0 := @parameter0: int;	lookupswitch(i0) {     case 3: goto $r1 = specialinvoke r0.<com.google.rpc.ErrorInfo$Builder: com.google.protobuf.MapField internalGetMutableMetadata()>();     default: goto $r8 = new java.lang.RuntimeException; };	$r8 = new java.lang.RuntimeException;	$r7 = new java.lang.StringBuilder;	specialinvoke $r7.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid map field number: ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r8.<java.lang.RuntimeException: void <init>(java.lang.String)>($r6);	throw $r8
;block_num 2
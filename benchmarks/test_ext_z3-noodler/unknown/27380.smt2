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

(declare-sort var772 0)
(declare-sort var458 0)
(declare-sort var586 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun readLength/1927450694 (var772) Int)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun is/107231720 (var772) var458)
(declare-fun read/-661881266 (var458 (Array Int Int) Int Int) Int)
(declare-fun var586-init () var586)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var586 String) void)
(declare-const null-var772 var772)
(declare-const var1947 var772) ; Statement: r0 := @this: org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput 
(assert (not (= var1947 null-var772)))
(assert true)
(define-const var3945 Int (readLength/1927450694 var1947)) ; Statement: i0 = specialinvoke r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: int readLength()>() 
(define-const var1556 (Array Int Int) arr-Int-init) ; Statement: r1 = newarray (byte)[i0] 
(define-const var2418 var458 (is/107231720 var1947)) ; Statement: $r2 = r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: java.io.InputStream is> 
(assert true)
(define-const var2936 Int (read/-661881266 var2418 var1556 0 var3945)) ; Statement: i1 = virtualinvoke $r2.<java.io.InputStream: int read(byte[],int,int)>(r1, 0, i0) 
 ; Statement: if i1 == i0 goto return r1 
(assert (not (= var2936 var3945))) ; Negate: Cond: i1 == i0  
(define-const var2538 var586 var586-init) ; Statement: $r3 = new java.lang.IllegalArgumentException 
(define-const var427 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var427)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var427!1 String)
(assert (= var427!1 ""))
(assert true)
(define-const var1361 String (append/672562846 var427!1 "deserialize failed. expected read length: ")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("deserialize failed. expected read length: ") 
(declare-const var427!2 String)
(assert (= var427!2 (str.++ var427!1 "deserialize failed. expected read length: ")))
(assert true)
(define-const var2274 String (append/-1001720160 var1361 var3945)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var1361!1 String)
(assert (str.prefixof var1361 var1361!1))
(assert true)
(define-const var3639 String (append/672562846 var2274 " but actual read: ")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" but actual read: ") 
(declare-const var2274!1 String)
(assert (= var2274!1 (str.++ var2274 " but actual read: ")))
(assert true)
(define-const var2497 String (append/-1001720160 var3639 var2936)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i1) 
(declare-const var3639!1 String)
(assert (str.prefixof var3639 var3639!1))
(assert true)
(define-const var359 String (toString/-2075883882 var2497)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var2538 var359)) ; Statement: specialinvoke $r3.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r9) 

(declare-const var2538!1 var586)
(declare-const var359!1 String)
 ; Statement: throw $r3 
(check-sat)
; {readLength/1927450694=([org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput], int), arr-Int-init=([], byte[]), is/107231720=([org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput], java.io.InputStream), read/-661881266=([java.io.InputStream, byte[], int, int], int), var586-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var772=org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput, var1947=r0, var3945=i0, var1556=r1, var458=java.io.InputStream, var2418=$r2, var2936=i1, var586=java.lang.IllegalArgumentException, var2538=$r3, var427=$r4, var1361=$r5, var2274=$r6, var3639=$r7, var2497=$r8, var359=$r9}
; {org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput=var772, r0=var1947, i0=var3945, r1=var1556, java.io.InputStream=var458, $r2=var2418, i1=var2936, java.lang.IllegalArgumentException=var586, $r3=var2538, $r4=var427, $r5=var1361, $r6=var2274, $r7=var3639, $r8=var2497, $r9=var359}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput;	i0 = specialinvoke r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: int readLength()>();	r1 = newarray (byte)[i0];	$r2 = r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: java.io.InputStream is>;	i1 = virtualinvoke $r2.<java.io.InputStream: int read(byte[],int,int)>(r1, 0, i0);	if i1 == i0 goto return r1;	$r3 = new java.lang.IllegalArgumentException;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("deserialize failed. expected read length: ");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" but actual read: ");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i1);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r3.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r9);	throw $r3
;block_num 2
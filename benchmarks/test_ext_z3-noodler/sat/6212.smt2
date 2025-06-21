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

(declare-sort var3074 0)
(declare-sort var346 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var346-init () var346)
(declare-fun <init>/481518073 (var346 String Int) void)
(declare-const null-String String)
(declare-const var2 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2 null-String)))
(assert true)
(define-const var2978 Int (indexOf/-1037706067 var2 58)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(58) 
(define-const var1655 Int (cast-from-Int-to-Int -1)) ; Statement: $i4 = (int) -1 
 ; Statement: if i0 <= $i4 goto r3 = r0 
(assert (<= var2978 var1655)) ; Cond: i0 <= $i4 
(define-const var2525 String var2) ; Statement: r3 = r0 
(define-const var2758 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
(define-const var1272 var346 var346-init) ; Statement: $r4 = new java.net.InetSocketAddress 
(assert true)
;(assert (<init>/481518073 var1272 var2525 var2758)) ; Statement: specialinvoke $r4.<java.net.InetSocketAddress: void <init>(java.lang.String,int)>(r3, i2) 

(declare-const var1272!1 var346)
(declare-const var2525!1 String)
(declare-const var2758!1 Int)
 ; Statement: return $r4 
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), cast-from-Int-to-Int=([int], int), var346-init=([], java.net.InetSocketAddress), <init>/481518073=([java.net.InetSocketAddress, java.lang.String, int], void)}
; {var2=r0, var3074=null_type, var2978=i0, var1655=$i4, var2525=r3, var2758=i2, var346=java.net.InetSocketAddress, var1272=$r4}
; {r0=var2, null_type=var3074, i0=var2978, $i4=var1655, r3=var2525, i2=var2758, java.net.InetSocketAddress=var346, $r4=var1272}
;seq <java.lang.String: int indexOf(int)>
;cnt {"<java.lang.String: int indexOf(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(58);	$i4 = (int) -1;	if i0 <= $i4 goto r3 = r0;	r3 = r0;	i2 = 0;	$r4 = new java.net.InetSocketAddress;	specialinvoke $r4.<java.net.InetSocketAddress: void <init>(java.lang.String,int)>(r3, i2);	return $r4
;block_num 3
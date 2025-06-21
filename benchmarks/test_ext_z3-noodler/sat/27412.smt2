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

(declare-sort var3589 0)
(declare-sort var3109 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun readLength/1927450694 (var3589) Int)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun is/107231720 (var3589) var3109)
(declare-fun read/-661881266 (var3109 (Array Int Int) Int Int) Int)
(declare-const null-var3589 var3589)
(declare-const var2833 var3589) ; Statement: r0 := @this: org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput 
(assert (not (= var2833 null-var3589)))
(assert true)
(define-const var3438 Int (readLength/1927450694 var2833)) ; Statement: i0 = specialinvoke r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: int readLength()>() 
(define-const var907 (Array Int Int) arr-Int-init) ; Statement: r1 = newarray (byte)[i0] 
(define-const var1677 var3109 (is/107231720 var2833)) ; Statement: $r2 = r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: java.io.InputStream is> 
(assert true)
(define-const var2553 Int (read/-661881266 var1677 var907 0 var3438)) ; Statement: i1 = virtualinvoke $r2.<java.io.InputStream: int read(byte[],int,int)>(r1, 0, i0) 
 ; Statement: if i1 == i0 goto return r1 
(assert (= var2553 var3438)) ; Cond: i1 == i0 
 ; Statement: return r1 
(check-sat)
; {readLength/1927450694=([org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput], int), arr-Int-init=([], byte[]), is/107231720=([org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput], java.io.InputStream), read/-661881266=([java.io.InputStream, byte[], int, int], int)}
; {var3589=org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput, var2833=r0, var3438=i0, var907=r1, var3109=java.io.InputStream, var1677=$r2, var2553=i1}
; {org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput=var3589, r0=var2833, i0=var3438, r1=var907, java.io.InputStream=var3109, $r2=var1677, i1=var2553}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput;	i0 = specialinvoke r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: int readLength()>();	r1 = newarray (byte)[i0];	$r2 = r0.<org.apache.dubbo.common.serialize.fastjson2.FastJson2ObjectInput: java.io.InputStream is>;	i1 = virtualinvoke $r2.<java.io.InputStream: int read(byte[],int,int)>(r1, 0, i0);	if i1 == i0 goto return r1;	return r1
;block_num 2
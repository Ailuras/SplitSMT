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

(declare-sort var375 0)
(declare-sort var3439 0)
(declare-sort var3306 0)
(declare-sort var1022 0)
(declare-sort var1576 0)
(declare-sort var2054 0)
(declare-sort var1965 0)
(declare-sort var3782 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getInvocationTime/675231966 (var375) var3439)
(declare-fun toInstant/-822818885 (var3439) var3306)
(declare-fun var1022_systemDefault/1019915793 () var1022)
(declare-fun var1576_ofInstant/129408697 (var3306 var1022) var1576)
(declare-fun format/372879155 (var1576 var2054) String)
(declare-fun getOutTime/324948452 (var375) var3439)
(declare-fun get/-1007821573 (var375 String) var1965)
(declare-fun append/-1031950772 (String var1965) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun toString/-522406933 (var1965) String)
(declare-fun var3782_isNotEmpty/-1251449450 (String) Bool)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun cast-from-var1965-to-__Array__Int__var1965__ (var1965) (Array Int var1965))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var375 var375)
(declare-const var375-MESSAGE_DATE_FORMATTER var2054)
(declare-const null-var1965 var1965)
(declare-const null-__Array__Int__var1965__ (Array Int var1965))
(declare-const var1903 var375) ; Statement: r1 := @this: org.apache.dubbo.rpc.support.AccessLogData 
(assert (not (= var1903 null-var375)))
(define-const var3294 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3294)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3294!1 String)
(assert (= var3294!1 ""))
(assert true)
(define-const var3832 String (append/672562846 var3294!1 "[")) ; Statement: $r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[") 
(declare-const var3294!2 String)
(assert (= var3294!2 (str.++ var3294!1 "[")))
(assert true)
(define-const var2090 var3439 (getInvocationTime/675231966 var1903)) ; Statement: $r2 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getInvocationTime()>() 
(assert true)
(define-const var3406 var3306 (toInstant/-822818885 var2090)) ; Statement: $r4 = virtualinvoke $r2.<java.util.Date: java.time.Instant toInstant()>() 
(define-const var1572 var1022 var1022_systemDefault/1019915793) ; Statement: $r3 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>() 
(define-const var3288 var1576 (var1576_ofInstant/129408697 var3406 var1572)) ; Statement: $r6 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r4, $r3) 
(define-const var3248 var2054 var375-MESSAGE_DATE_FORMATTER) ; Statement: $r5 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER> 
(assert true)
(define-const var1283 String (format/372879155 var3288 var3248)) ; Statement: $r7 = virtualinvoke $r6.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r5) 
(assert true)
(define-const var3277 String (append/672562846 var3832 var1283)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var3832!1 String)
(assert (= var3832!1 (str.++ var3832 var1283)))
(assert true)
(define-const var3593 String (append/672562846 var3277 "] ")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ") 
(declare-const var3277!1 String)
(assert (= var3277!1 (str.++ var3277 "] ")))
(assert true)
(define-const var3903 String (append/672562846 var3593 "-> ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-> ") 
(declare-const var3593!1 String)
(assert (= var3593!1 (str.++ var3593 "-> ")))
(assert true)
(define-const var3921 String (append/672562846 var3903 "[")) ; Statement: $r18 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[") 
(declare-const var3903!1 String)
(assert (= var3903!1 (str.++ var3903 "[")))
(assert true)
(define-const var3751 var3439 (getOutTime/324948452 var1903)) ; Statement: $r12 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getOutTime()>() 
(assert true)
(define-const var2712 var3306 (toInstant/-822818885 var3751)) ; Statement: $r14 = virtualinvoke $r12.<java.util.Date: java.time.Instant toInstant()>() 
(define-const var3520 var1022 var1022_systemDefault/1019915793) ; Statement: $r13 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>() 
(define-const var611 var1576 (var1576_ofInstant/129408697 var2712 var3520)) ; Statement: $r16 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r14, $r13) 
(define-const var2110 var2054 var375-MESSAGE_DATE_FORMATTER) ; Statement: $r15 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER> 
(assert true)
(define-const var2429 String (format/372879155 var611 var2110)) ; Statement: $r17 = virtualinvoke $r16.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r15) 
(assert true)
(define-const var2645 String (append/672562846 var3921 var2429)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17) 
(declare-const var3921!1 String)
(assert (= var3921!1 (str.++ var3921 var2429)))
(assert true)
(define-const var90 String (append/672562846 var2645 "] ")) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ") 
(declare-const var2645!1 String)
(assert (= var2645!1 (str.++ var2645 "] ")))
(assert true)
(define-const var2921 var1965 (get/-1007821573 var1903 "remote-host")) ; Statement: $r20 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-host") 
(assert true)
(define-const var1717 String (append/-1031950772 var90 var2921)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20) 
(declare-const var90!1 String)
(assert (str.prefixof var90 var90!1))
(assert true)
(define-const var1674 String (append/-1166366385 var1717 58)) ; Statement: $r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var1717!1 String)
(assert (str.prefixof var1717 var1717!1))
(assert true)
(define-const var1769 var1965 (get/-1007821573 var1903 "remote-port")) ; Statement: $r23 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-port") 
(assert true)
(define-const var3889 String (append/-1031950772 var1674 var1769)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23) 
(declare-const var1674!1 String)
(assert (str.prefixof var1674 var1674!1))
(assert true)
(define-const var1595 String (append/672562846 var3889 " -> ")) ; Statement: $r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var3889!1 String)
(assert (= var3889!1 (str.++ var3889 " -> ")))
(assert true)
(define-const var1690 var1965 (get/-1007821573 var1903 "localhost")) ; Statement: $r26 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("localhost") 
(assert true)
(define-const var2948 String (append/-1031950772 var1595 var1690)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r26) 
(declare-const var1595!1 String)
(assert (str.prefixof var1595 var1595!1))
(assert true)
(define-const var2751 String (append/-1166366385 var2948 58)) ; Statement: $r30 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var2948!1 String)
(assert (str.prefixof var2948 var2948!1))
(assert true)
(define-const var2932 var1965 (get/-1007821573 var1903 "local-port")) ; Statement: $r29 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("local-port") 
(assert true)
(define-const var267 String (append/-1031950772 var2751 var2932)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29) 
(declare-const var2751!1 String)
(assert (str.prefixof var2751 var2751!1))
(assert true)
;(assert (append/672562846 var267 " - ")) ; Statement: virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" - ") 
(declare-const var267!1 String)
(assert (= var267!1 (str.++ var267 " - ")))
(assert true)
(define-const var2069 var1965 (get/-1007821573 var1903 "group")) ; Statement: $r32 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group") 
 ; Statement: if $r32 == null goto $r47 = "" 
(assert (not (= var2069 null-var1965))) ; Negate: Cond: $r32 == null  
(assert true)
(define-const var250 var1965 (get/-1007821573 var1903 "group")) ; Statement: $r46 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group") 
(assert true)
(define-const var1652 String (toString/-522406933 var250)) ; Statement: $r47 = virtualinvoke $r46.<java.lang.Object: java.lang.String toString()>() 
 ; Statement: goto [?= $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47)] 
(assert true) ; Non Conditional
(define-const var3264 Bool (var3782_isNotEmpty/-1251449450 var1652)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47) 
 ; Statement: if $z0 == 0 goto $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service") 
(assert (= (ite var3264 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var79 var1965 (get/-1007821573 var1903 "service")) ; Statement: $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service") 
(assert true)
;(assert (append/-1031950772 var3294!2 var79)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33) 
(declare-const var3294!3 String)
(assert (str.prefixof var3294!2 var3294!3))
(assert true)
(define-const var2434 var1965 (get/-1007821573 var1903 "version")) ; Statement: $r34 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version") 
 ; Statement: if $r34 == null goto $r48 = "" 
(assert (not (= var2434 null-var1965))) ; Negate: Cond: $r34 == null  
(assert true)
(define-const var919 var1965 (get/-1007821573 var1903 "version")) ; Statement: $r44 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version") 
(assert true)
(define-const var1830 String (toString/-522406933 var919)) ; Statement: $r48 = virtualinvoke $r44.<java.lang.Object: java.lang.String toString()>() 
 ; Statement: goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48)] 
(assert true) ; Non Conditional
(define-const var309 Bool (var3782_isNotEmpty/-1251449450 var1830)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48) 
 ; Statement: if $z1 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(assert (= (ite var309 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
;(assert (append/-1166366385 var3294!3 32)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var3294!4 String)
(assert (str.prefixof var3294!3 var3294!4))
(assert true)
(define-const var1959 var1965 (get/-1007821573 var1903 "method-name")) ; Statement: $r35 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("method-name") 
(assert true)
;(assert (append/-1031950772 var3294!4 var1959)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r35) 
(declare-const var3294!5 String)
(assert (str.prefixof var3294!4 var3294!5))
(assert true)
;(assert (append/-1166366385 var3294!5 40)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var3294!6 String)
(assert (str.prefixof var3294!5 var3294!6))
(assert true)
(define-const var2984 var1965 (get/-1007821573 var1903 "types")) ; Statement: $r36 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types") 
 ; Statement: if $r36 == null goto $r49 = newarray (java.lang.Class)[0] 
(assert (= var2984 null-var1965)) ; Cond: $r36 == null 
(define-const var1680 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r49 = newarray (java.lang.Class)[0] 
(assert true) ; Non Conditional
(define-const var598 Bool (ite (= 1 1) true false)) ; Statement: z2 = 1 
(define-const var1968 (Array Int ClassObject) var1680) ; Statement: r50 = $r49 
(define-const var3541 Int (getLength-Arr-ClassObject-1 var1680)) ; Statement: $i1 = lengthof $r49 
(define-const var1213 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= $i1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(assert (>= var1213 var3541)) ; Cond: i2 >= $i1 
(assert true)
;(assert (append/672562846 var3294!6 ") ")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var3294!7 String)
(assert (= var3294!7 (str.++ var3294!6 ") ")))
(assert true)
(define-const var1285 var1965 (get/-1007821573 var1903 "arguments")) ; Statement: $r37 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments") 
 ; Statement: if $r37 == null goto $r51 = null 
(assert (not (= var1285 null-var1965))) ; Negate: Cond: $r37 == null  
(assert true)
(define-const var842 var1965 (get/-1007821573 var1903 "arguments")) ; Statement: $r39 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments") 
(define-const var654 (Array Int var1965) (cast-from-var1965-to-__Array__Int__var1965__ var842)) ; Statement: $r51 = (java.lang.Object[]) $r39 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if $r51 == null goto $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= var654 null-__Array__Int__var1965__)) ; Cond: $r51 == null 
(assert true)
(define-const var3174 String (toString/-2075883882 var3294!7)) ; Statement: $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r52 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getInvocationTime/675231966=([org.apache.dubbo.rpc.support.AccessLogData], java.util.Date), toInstant/-822818885=([java.util.Date], java.time.Instant), var1022_systemDefault/1019915793=([], java.time.ZoneId), var1576_ofInstant/129408697=([java.time.Instant, java.time.ZoneId], java.time.LocalDateTime), format/372879155=([java.time.LocalDateTime, java.time.format.DateTimeFormatter], java.lang.String), getOutTime/324948452=([org.apache.dubbo.rpc.support.AccessLogData], java.util.Date), get/-1007821573=([org.apache.dubbo.rpc.support.AccessLogData, java.lang.String], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-522406933=([java.lang.Object], java.lang.String), var3782_isNotEmpty/-1251449450=([java.lang.String], boolean), arr-ClassObject-init=([], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), cast-from-var1965-to-__Array__Int__var1965__=([java.lang.Object], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var375=org.apache.dubbo.rpc.support.AccessLogData, var1903=r1, var3294=$r0, var3832=$r8, var3439=java.util.Date, var2090=$r2, var3306=java.time.Instant, var3406=$r4, var1022=java.time.ZoneId, var1572=$r3, var1576=java.time.LocalDateTime, var3288=$r6, var2054=java.time.format.DateTimeFormatter, var3248=$r5, var1283=$r7, var3277=$r9, var3593=$r10, var3903=$r11, var3921=$r18, var3751=$r12, var2712=$r14, var3520=$r13, var611=$r16, var2110=$r15, var2429=$r17, var2645=$r19, var90=$r21, var1965=java.lang.Object, var2921=$r20, var1717=$r22, var1674=$r24, var1769=$r23, var3889=$r25, var1595=$r27, var1690=$r26, var2948=$r28, var2751=$r30, var2932=$r29, var267=$r31, var2069=$r32, var250=$r46, var1652=$r47, var3782=org.apache.dubbo.common.utils.StringUtils, var3264=$z0, var79=$r33, var2434=$r34, var919=$r44, var1830=$r48, var309=$z1, var1959=$r35, var2984=$r36, var1680=$r49, var598=z2, var1968=r50, var3541=$i1, var1213=i2, var1285=$r37, var842=$r39, var654=$r51, var3174=$r52}
; {org.apache.dubbo.rpc.support.AccessLogData=var375, r1=var1903, $r0=var3294, $r8=var3832, java.util.Date=var3439, $r2=var2090, java.time.Instant=var3306, $r4=var3406, java.time.ZoneId=var1022, $r3=var1572, java.time.LocalDateTime=var1576, $r6=var3288, java.time.format.DateTimeFormatter=var2054, $r5=var3248, $r7=var1283, $r9=var3277, $r10=var3593, $r11=var3903, $r18=var3921, $r12=var3751, $r14=var2712, $r13=var3520, $r16=var611, $r15=var2110, $r17=var2429, $r19=var2645, $r21=var90, java.lang.Object=var1965, $r20=var2921, $r22=var1717, $r24=var1674, $r23=var1769, $r25=var3889, $r27=var1595, $r26=var1690, $r28=var2948, $r30=var2751, $r29=var2932, $r31=var267, $r32=var2069, $r46=var250, $r47=var1652, org.apache.dubbo.common.utils.StringUtils=var3782, $z0=var3264, $r33=var79, $r34=var2434, $r44=var919, $r48=var1830, $z1=var309, $r35=var1959, $r36=var2984, $r49=var1680, z2=var598, r50=var1968, $i1=var3541, i2=var1213, $r37=var1285, $r39=var842, $r51=var654, $r52=var3174}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.Object: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.Object: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 10,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 4,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.support.AccessLogData;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[");	$r2 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getInvocationTime()>();	$r4 = virtualinvoke $r2.<java.util.Date: java.time.Instant toInstant()>();	$r3 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>();	$r6 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r4, $r3);	$r5 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER>;	$r7 = virtualinvoke $r6.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r5);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-> ");	$r18 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[");	$r12 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getOutTime()>();	$r14 = virtualinvoke $r12.<java.util.Date: java.time.Instant toInstant()>();	$r13 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>();	$r16 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r14, $r13);	$r15 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER>;	$r17 = virtualinvoke $r16.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r15);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ");	$r20 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-host");	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20);	$r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r23 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-port");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23);	$r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r26 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("localhost");	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r26);	$r30 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r29 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("local-port");	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29);	virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" - ");	$r32 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group");	if $r32 == null goto $r47 = "";	$r46 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group");	$r47 = virtualinvoke $r46.<java.lang.Object: java.lang.String toString()>();	goto [?= $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47)];	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47);	if $z0 == 0 goto $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service");	$r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33);	$r34 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version");	if $r34 == null goto $r48 = "";	$r44 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version");	$r48 = virtualinvoke $r44.<java.lang.Object: java.lang.String toString()>();	goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48)];	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48);	if $z1 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r35 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("method-name");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r35);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	$r36 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types");	if $r36 == null goto $r49 = newarray (java.lang.Class)[0];	$r49 = newarray (java.lang.Class)[0];	z2 = 1;	r50 = $r49;	$i1 = lengthof $r49;	i2 = 0;	if i2 >= $i1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r37 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments");	if $r37 == null goto $r51 = null;	$r39 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments");	$r51 = (java.lang.Object[]) $r39;	goto [?= (branch)];	if $r51 == null goto $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r52
;block_num 14